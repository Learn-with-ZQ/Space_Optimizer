import tensorflow as tf
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import itertools
import numpy as np
import time
import random

def create_Rectangle(length, width, place):
    rectangle = tf.fill((width, length), place)
    return rectangle

def create_Triangle(width, place):
    triangle = tf.zeros((width, width), dtype=tf.int32)
    for i in range(width):
        triangle = tf.tensor_scatter_nd_update(triangle, [[i, width - i - 1 + j] for j in range(2*i+1)], [place]*(2*i+1))
    return triangle

def create_Parallelogram(length, width, place):
    parallelogram = tf.zeros((width, length + width - 1), dtype=tf.int32)
    for i in range(width):
        parallelogram = tf.tensor_scatter_nd_update(parallelogram, [[i, width - i - 1 + j] for j in range(length)], [place]*length)
    return parallelogram

def create_Hexagon(length, place, container_shape):
    triangle = create_Triangle(length, place)
    triangle_flipped = tf.reverse(triangle, axis=[0])
    rectangle = tf.fill((length - 2, 2 * length - 1), place)

    max_rows = tf.maximum(tf.shape(triangle)[0], tf.shape(rectangle)[0], tf.shape(triangle_flipped)[0])
    max_cols = tf.maximum(tf.shape(triangle)[1], tf.shape(rectangle)[1], tf.shape(triangle_flipped)[1])

    triangle = tf.pad(triangle, [[0, max_rows - tf.shape(triangle)[0]], [0, max_cols - tf.shape(triangle)[1]]])
    rectangle = tf.pad(rectangle, [[0, max_rows - tf.shape(rectangle)[0]], [0, max_cols - tf.shape(rectangle)[1]]])
    triangle_flipped = tf.pad(triangle_flipped, [[0, max_rows - tf.shape(triangle_flipped)[0]], [0, max_cols - tf.shape(triangle_flipped)[1]]])

    hexagon = tf.concat([triangle, rectangle, triangle_flipped], axis=0)

    hexagon = hexagon[:container_shape[0], :container_shape[1]]

    return hexagon

def Outcomes(j, k, row, container):
    objects = []
    selected = []
    if row['Shape_Type'] == "Rectangle":
        rectangle = create_Rectangle(row['ShapeLength'], row['ShapeWidth'], len(j) + 1)
        if tf.shape(rectangle)[0] <= tf.shape(container)[0] and tf.shape(rectangle)[1] <= tf.shape(container)[1]:
            objects.append(j + [resize_shape(rectangle, container)])
            selected.append(k + [row['ShapeName']])
        rectangle_T = tf.transpose(rectangle)
        if tf.shape(rectangle_T)[0] <= tf.shape(container)[0] and tf.shape(rectangle_T)[1] <= tf.shape(container)[1]:
            objects.append(j + [resize_shape(rectangle_T, container)])
            selected.append(k + [row['ShapeName']])
    # Add other shape types using TensorFlow operations similarly
    
    return objects, selected

def resize_shape(shape, target_shape):
    """
    Resize the shape to match the target shape by padding or cropping.
    """
    resized_shape = tf.zeros(target_shape, dtype=shape.dtype)
    rows = tf.minimum(tf.shape(shape)[0], target_shape[0])
    cols = tf.minimum(tf.shape(shape)[1], target_shape[1])
    resized_shape[:rows, :cols].assign(shape[:rows, :cols])
    return resized_shape

def add_arrays_with_rotation(arr1, arr2):
    for _ in range(4):
        arr1 = tf.image.rot90(arr1)
        if tf.shape(arr1) == tf.shape(arr2) and tf.reduce_sum(arr1 * arr2) == 0:
            return arr1 + arr2
    return arr2

def Main(container_Dim, dataset, userID):
    container = tf.zeros((container_Dim[1], container_Dim[0]), dtype=tf.int32)
    objects = [[]]
    selected = [[]]
    for row in dataset:
        for _ in range(row['Quantity']):
            objects_temp = []
            selected_temp = []
            for j, k in zip(objects, selected):
                temp = Outcomes(j, k, row, container)
                if temp[0] is not None:
                    objects_temp.extend(temp[0])
                if temp[1] is not None:
                    selected_temp.extend(temp[1])
            objects = objects_temp
            selected = selected_temp

    wasted_area = tf.reduce_sum(tf.cast(container == 0, tf.int32))
    result_array = tf.zeros_like(container)

    if len(objects) > len(container_Dim) * 5:
        selected_index = random.sample(range(len(objects)), min(50, len(objects)))
        objects = [objects[i] for i in selected_index]
        selected = [selected[i] for i in selected_index]

    for k, l in zip(objects, selected):
        objects_temp = []
        selected_temp = []
        for ob, sl in zip(itertools.permutations(k), itertools.permutations(l)):
            objects_temp.append(list(ob))
            selected_temp.append(list(sl))
            if len(objects_temp) >= len(container_Dim) * 10:
                break

        for j in range(len(objects_temp)):
            temp = container
            selected_temp_new = []
            for i in range(len(objects_temp[j])):
                temp1 = add_arrays_with_rotation(objects_temp[j][i], temp)
                if not tf.reduce_all(tf.equal(temp1, temp)):
                    selected_temp_new.append(selected_temp[j][i])
                temp = temp1
            if tf.reduce_sum(tf.cast(temp == 0, tf.int32)) < wasted_area:
                result_array = temp
                wasted_area = tf.reduce_sum(tf.cast(temp == 0, tf.int32))
                selected_shapes = selected_temp_new
    result_arr = list(result_array)
    unique_values = tf.unique(tf.reshape(result_array, [-1]))[0]
    colors = plt.cm.tab10.colors[:tf.size(unique_values)]

    fig, ax = plt.subplots()
    im = ax.imshow(tf.zeros(result_array.shape + (3,), dtype=tf.float32), interpolation='nearest', aspect='auto')

    for i, value in enumerate(unique_values):
        if value == 0:
            continue
        color_index = tf.where(tf.equal(tf.unique(tf.reshape(result_array, [-1]))[0], value))[0][0]
        color = colors[color_index][:3]
        im = tf.where(tf.equal(result_array, value), color, im)

    # Convert AxesImage to NumPy array
    im_array = np.array(im.get_array())

    ax.imshow(im_array, interpolation='nearest', aspect='auto')
    ax.set_xticks(tf.range(result_array.shape[1]))
    ax.set_yticks(tf.range(result_array.shape[0]))
    ax.set_xticklabels(tf.range(result_array.shape[1]))
    ax.set_yticklabels(tf.range(result_array.shape[0]))
    ax.tick_params(labelsize=8)
    ax.grid(color='w', linestyle='-', linewidth=1)
    plt.savefig(f'Output_images/{userID}_image_{time.strftime("%Y-%m-%d_%H-%M-%S")}.png')
    plt.show()
    plt.close()

    return wasted_area, selected_shapes

result = [
    {'ShapeName': 'Shape7', 'Shape_Type': 'Hexagon', 'ShapeWidth': 4, 'ShapeLength': 4, 'Quantity': 5},
    {'ShapeName': 'Shape6', 'Shape_Type': 'Parallelogram', 'ShapeWidth': 4, 'ShapeLength': 3, 'Quantity': 5},
    {'ShapeName': 'Shape4', 'Shape_Type': 'Triangle', 'ShapeWidth': 3, 'ShapeLength': 3, 'Quantity': 5},
    {'ShapeName': 'Shape1', 'Shape_Type': 'Rectangle', 'ShapeWidth': 2, 'ShapeLength': 3, 'Quantity': 5},
    {'ShapeName': 'Shape2', 'Shape_Type': 'Square', 'ShapeWidth': 2, 'ShapeLength': 2, 'Quantity': 5},
    {'ShapeName': 'Shape3', 'Shape_Type': 'Square', 'ShapeWidth': 1, 'ShapeLength': 1, 'Quantity': 8},
    {'ShapeName': 'Shape1', 'Shape_Type': 'Rectangle', 'ShapeWidth': 2, 'ShapeLength': 3, 'Quantity': 5},
    {'ShapeName': 'Shape2', 'Shape_Type': 'Square', 'ShapeWidth': 2, 'ShapeLength': 2, 'Quantity': 5}
    # Add more rows as needed
]

start_time = time.time()
Main([10, 7], result, "Admin_1")
end_time = time.time()
elapsed_time = end_time - start_time
print(elapsed_time)
