from flask import Flask, request, jsonify
from datetime import datetime
import numpy as np
import matplotlib.pyplot as plt
from scipy.spatial import distance
import random
import itertools
import os
import time


def create_Rectangle(length,width,place):
    rectangle = [[place for j in range(length)] for i in range(width)]
    return rectangle

def create_Triangle(width,place):
    triangle = []
    for i in range(width):
        triangle.append([])
        triangle[-1] = [0 for j in range(width - i - 1)]
        triangle[-1] += [place for j in range(2 * i + 1)]
        triangle[-1] += [0 for j in range(width - i - 1)]
    return triangle

def create_Parallelogram(length,width,place): 
    parallelogram = []
    for i in range(width):
        parallelogram.append([])
        parallelogram[-1] = [0 for i in range(width - i -1)]
        parallelogram[-1] += [place for i in range(length)]
        parallelogram[-1] += [0 for i in range(i)]
    return parallelogram

def create_Rhombus(length, place):
    triangle1 = create_Triangle(length, place)
    triangle2 = triangle1[::-1]
    return triangle1 + triangle2[1:]

def create_Hexagon(length, place):
    triangle1 = create_Triangle(length, place)
    triangle2 = triangle1[::-1]
    rectangle = [[place for i in range(i + 2 * length - (i*2) - 1 + i)] for i in range(length -2)]
    return triangle1 + rectangle + triangle2

def resize_2d_array(arr, container):
    # Create a new 2D array with the desired size
    if len(arr) <= len(container) and len(arr[0]) <= len(container[0]):
        new_rows, new_columns = len(container), len(container[0])
        new_arr = [[0] * new_columns for _ in range(new_rows)]

        # Copy elements from the old array to the new array
        for i in range(min(len(arr), new_rows)):
            for j in range(min(len(arr[0]), new_columns)):
                new_arr[i][j] = arr[i][j]
        return new_arr
    return 0    

def Outcomes(j, k, row, container):
    objects = []
    selected = []
    if row['Shape_Type'] == "Rectangle":
        rectangle = create_Rectangle(row['ShapeLength'], row['ShapeWidth'], len(j) + 1)
        temp = resize_2d_array(rectangle, container)
        if temp != 0:
            objects.append(j + [temp])
            selected.append(k + [row['ShapeName']])
        temp = resize_2d_array(list(map(list, zip(*rectangle))), container)
        if temp != 0:
            objects.append(j + [temp])
            selected.append(k + [row['ShapeName']])
    if row['Shape_Type'] == "Square":
        square = create_Rectangle(row['ShapeLength'], row['ShapeLength'], len(j) + 1)
        temp = resize_2d_array(square, container)
        if temp != 0:
            objects.append(j + [temp])
            selected.append(k + [row['ShapeName']])
    if row['Shape_Type'] == "Triangle":
        triangle = create_Triangle(row['ShapeLength'], len(j) + 1)
        temp = resize_2d_array(triangle, container)
        if temp != 0:
            objects.append(j + [temp])
            selected.append(k + [row['ShapeName']])
            objects.append(j +[resize_2d_array(triangle[::-1], container)])
            selected.append(k + [row['ShapeName']])
        temp = resize_2d_array(list(map(list, zip(*triangle))), container)
        if temp != 0:
            objects.append(j + [temp])
            selected.append(k + [row['ShapeName']])
        temp = resize_2d_array(list(map(list, zip(*triangle[::-1]))), container)
        if temp != 0:
            objects.append(j + [temp])
            selected.append(k + [row['ShapeName']])
    if row['Shape_Type'] == "Parallelogram":
        parallelogram = create_Parallelogram(row['ShapeLength'], row['ShapeWidth'], len(j) + 1)
        temp = resize_2d_array(parallelogram, container)
        if temp != 0:
            objects.append(j + [temp])
            selected.append(k + [row['ShapeName']])
        temp = resize_2d_array(list(map(list, zip(*parallelogram))), container)
        if temp != 0:
            objects.append(j + [temp])
            selected.append(k + [row['ShapeName']])
    if row['Shape_Type'] == "Rhombus":
        rhombus = create_Parallelogram(row['ShapeLength'], len(j) + 1)
        temp = resize_2d_array(rhombus, container)
        if temp != 0:
            objects.append(j + [temp])
            selected.append(k + [row['ShapeName']])
    if row['Shape_Type'] == "Hexagon":
        hexagon = create_Hexagon(row['ShapeLength'], len(j) + 1)
        temp = resize_2d_array(hexagon, container)
        if temp != 0:
            objects.append(j + [temp])
            selected.append(k + [row['ShapeName']])
        temp = resize_2d_array(list(map(list, zip(*hexagon))), container)
        if temp != 0:
            objects.append(j + [temp])
            selected.append(k + [row['ShapeName']])
    return objects, selected

def rotate_matrix_right(matrix):
    if all(row[-1] == 0 for row in matrix):
        rotated_matrix = [row[-1:] + row[:-1] for row in matrix]
        return rotated_matrix
    return 1

def shift_matrix_down(matrix):
    num_rows = len(matrix)
    num_cols = len(matrix[0])

    # Check if the last column contains only zeros
    if all(row == 0 for row in matrix[-1]):
        # If yes, then rotate the matrix up
        shifted_matrix = [[0] * num_cols for _ in range(num_rows)]
        for col in range(num_cols):
            for row in range(num_rows):
                shifted_row = (row - 1) % num_rows
                shifted_matrix[row][col] = matrix[shifted_row][col]
        return shifted_matrix
    else:
        # If no, return 1
        return 1

def add_arrays_with_rotation(arr1, arr2):
    local_array = arr1
    result = [[0 for j in i] for i in arr1]
    i = 0
    while i < len(arr1):
        checker = 0
        for j in range(len(arr1[0])):
            if (arr1[i][j] == 0 and arr2[i][j] == 0) or (arr1[i][j] != 0 and arr2[i][j] == 0) or (arr1[i][j] == 0 and arr2[i][j] != 0):
                result[i][j] = arr1[i][j] + arr2[i][j]
            else:
                checker = 1
                break
        if checker == 1:
            temp = rotate_matrix_right(arr1)
            if temp != 1:
                arr1 = temp
            else:
                arr1 = local_array
                temp = shift_matrix_down(arr1)
                if temp != 1:
                    arr1 = temp
                    local_array = arr1
                else:
                    return arr2
            result = [[0 for j in i] for i in arr1]
            i = 0
        else:
            i += 1
    return result

def random_number(existing_colors, threshold=100):
    while True:
        red = np.random.randint(0, 256, dtype=int)
        green = np.random.randint(0, 256, dtype=int)
        blue = np.random.randint(0, 256, dtype=int)
        new_color = [red, green, blue]

        # Check if the new color is significantly different from existing colors
        if all(distance.euclidean(new_color, existing_color) > threshold for existing_color in existing_colors):
            break
    return new_color

def convert_to_3d_array(data):
    unique_values = np.unique(data)
    my_dict = {}  # Create an empty dictionary    
    for i in unique_values:
        temp = [100, 100, 100]
        if i == 0:
            temp = [255, 255, 255]
        elif i > 0:
            while True:
                temp = random_number(list(my_dict.values()))
                if tuple(temp) not in my_dict.values():
                    break
        my_dict[i] = list(temp)

    converted_data = [[my_dict[j] for j in i] for i in data]
    return converted_data

def Main(container_Dim, dataset, userID):
    container = create_Rectangle(container_Dim[0], container_Dim[1], 0)
    objects = [[]]
    selected = [[]]
    for row in dataset:
        for i in range(row['Quantity']):
            objects_temp = []
            selected_temp = []
            for j, k in zip(objects, selected):
                temp = Outcomes(j, k, row, container)
                objects_temp.extend(temp[0])
                selected_temp.extend(temp[1])
            objects = objects_temp
            selected = selected_temp

    wasted_area = sum(row.count(0) for row in container)
    result_array = []
    if len(objects) > 10:
        selected_index = [random.randint(0, len(objects)-1) for _ in range(random.randint(10, min(50,len(objects))))]
        objects = [objects[i] for i in selected_index]
        selected = [selected[i] for i in selected_index]
    for k, l in zip(objects, selected):
        objects_temp = []  # Initialize objects_wasted_aretemp inside the outer loop
        selected_temp = []  # Initialize selected_temp inside the outer loop
        
        for ob, sl in zip(itertools.permutations(k), itertools.permutations(l)):
            objects_temp.append(list(ob))
            selected_temp.append(list(sl))

            # Check if the limit is reached
            if len(objects_temp) >= len(k):
                break

        for j in range(len(objects_temp)):
            temp = container
            selected_temp_new = []
            for i in range(len(objects_temp[j])):
                temp1 = add_arrays_with_rotation(objects_temp[j][i], temp)
                if temp1 != temp:
                    selected_temp_new.append(selected_temp[j][i])
                temp = temp1
            if sum(row.count(0) for row in temp) < wasted_area:
                result_array = temp
                wasted_area = sum(row.count(0) for row in result_array)
                selected_shapes = selected_temp_new

    test = np.unique(result_array[result_array != 0])
    for value in test:
        if value == 0:
            continue
        color_index = np.where(np.unique(result_array) == value)[0][0]
        color = plt.cm.get_cmap("tab10", len(test))(color_index)
    
    image_3d_array = np.array(convert_to_3d_array(result_array))
    fig, ax = plt.subplots()
    im = ax.imshow(image_3d_array, cmap=None, interpolation='nearest', aspect='auto', origin='lower')

    # Set tick positions to cover the entire array
    ax.set_xticks(np.arange(image_3d_array.shape[1]))
    ax.set_yticks(np.arange(image_3d_array.shape[0]))

    # Set tick labels at adjusted positions
    tick_positions_x = np.arange(image_3d_array.shape[1] + 1) - 0.5  # Move labels towards the origin
    tick_positions_y = np.arange(image_3d_array.shape[0] + 1) - 0.5  # Move labels towards the origin
    ax.set_xticks(tick_positions_x)
    ax.set_yticks(tick_positions_y)

    # Optionally, you can add tick labels if needed
    ax.set_xticklabels(tick_positions_x + 0.5)
    ax.set_yticklabels(tick_positions_y + 0.5)
    filename = f'\\Output_images\\{userID}_image_{datetime.now().strftime("%Y-%m-%d_%H-%M-%S")}.png'
    try:
        plt.savefig(f"{os.getcwd()}{filename}")
        filename = filename.replace("\\", "/")
    except Exception as e:
        print(e)
    plt.close()

    return filename, wasted_area, selected_shapes

result = [
    {'ShapeName': 'Shape7', 'Shape_Type': 'Hexagon', 'ShapeWidth': 4, 'ShapeLength': 4, 'Quantity': 1},
    {'ShapeName': 'Shape6', 'Shape_Type': 'Parallelogram', 'ShapeWidth': 4, 'ShapeLength': 3, 'Quantity': 1},
    {'ShapeName': 'Shape4', 'Shape_Type': 'Triangle', 'ShapeWidth': 3, 'ShapeLength': 3, 'Quantity': 1},
    {'ShapeName': 'Shape1', 'Shape_Type': 'Rectangle', 'ShapeWidth': 2, 'ShapeLength': 3, 'Quantity': 1},
    {'ShapeName': 'Shape2', 'Shape_Type': 'Square', 'ShapeWidth': 2, 'ShapeLength': 2, 'Quantity': 5},
    {'ShapeName': 'Shape3', 'Shape_Type': 'Square', 'ShapeWidth': 1, 'ShapeLength': 1, 'Quantity': 8 },
    {'ShapeName': 'Shape1', 'Shape_Type': 'Rectangle', 'ShapeWidth': 2, 'ShapeLength': 3, 'Quantity': 1},
    {'ShapeName': 'Shape2', 'Shape_Type': 'Square', 'ShapeWidth': 2, 'ShapeLength': 2, 'Quantity': 2 }
    # Add more rows as needed
]

start_time = time.time()
Main([10, 7], result, "Admin_1")
end_time = time.time()  # Record end time
elapsed_time = end_time - start_time  # Calculate elapsed time
print(elapsed_time)