import matplotlib
matplotlib.use('Agg')
from flask import Flask, request, jsonify
from datetime import datetime
import numpy as np
import matplotlib.pyplot as plt
from scipy.spatial import distance
import random
import itertools
import os
import time
import asyncio
import aiohttp

def create_Rectangle(length,width,place):
    rectangle = np.full((width, length), place)
    return rectangle

def create_Triangle(width,place):
    triangle = create_Rectangle(width*2-1,width,0)
    for i in range(width):
        for j in range((width - i - 1), (width - i - 1)+(2 * i + 1)):
            triangle[i][j] = place
    return triangle

def create_Parallelogram(length,width,place): 
    parallelogram = create_Rectangle(length+width-1,width,0)
    for i in range(width):
        for j in range((width - i -1), (width - i -1) + (length)):
            parallelogram[i][j] = place
    return parallelogram

def create_Rhombus(length, place):
    triangle = create_Triangle(length, place)
    return np.concatenate((triangle, np.rot90(triangle[:-1], k=2)), axis=0)

def create_Hexagon(length, place):
    triangle = create_Triangle(length, place)
    rectangle = create_Rectangle(2 * length - 1,length-1,place)
    return np.concatenate((triangle, rectangle, np.rot90(triangle[:-1], k=2)), axis=0)

def resize_2d_array(objects, container):
    if objects.shape[0] <= container.shape[0] and objects.shape[1] <= container.shape[1]:
        container = np.copy(container)
        container[:objects.shape[0], :objects.shape[1]] = objects
        return container
    return None

def rotate_matrix_right(matrix):
    matrix_np = np.array(matrix)
    if np.all(matrix_np[:, -1] == 0):
        rotated_matrix_np = np.roll(matrix_np, 1, axis=1)
        return rotated_matrix_np
    return None

def shift_matrix_down(matrix):    
    print(matrix)
    if np.all(matrix[-1] == 0):
        shifted_matrix_np = np.zeros_like(matrix)
        shifted_matrix_np[1:] = matrix[:-1]
        return shifted_matrix_np
    return None

def process_shape(shape, j, k, shape_name, container):
    temp = resize_2d_array(shape, container)
    if temp is not None:
        return objects.append(j + [temp]), selected.append(k + [shape_name])
    return objects, selected

def Outcomes(j, k, row, container):
    objects = []
    selected = []
    
    if row['Shape_Type'] == "Rectangle":
        rectangle = create_Rectangle(row['ShapeLength'], row['ShapeWidth'], len(j) + 1)
        objects, selected = process_shape(rectangle, j, k, row['ShapeName'], container)
        objects, selected = process_shape(np.transpose(rectangle), j, k, row['ShapeName'], container)
        
    elif row['Shape_Type'] == "Square":
        square = create_Rectangle(row['ShapeLength'], row['ShapeLength'], len(j) + 1)
        objects, selected = process_shape(square, j, k, row['ShapeName'], container)
    
    elif row['Shape_Type'] == "Triangle":
        triangle = create_Triangle(row['ShapeLength'], len(j) + 1)
        objects, selected = process_shape(triangle, j, k, row['ShapeName'], container)
        objects, selected = process_shape(np.flip(triangle, axis=0), j, k, row['ShapeName'], container)
        objects, selected = process_shape(np.transpose(triangle), j, k, row['ShapeName'], container)
        objects, selected = process_shape(np.flip(np.transpose(triangle), axis=0), j, k, row['ShapeName'], container)
    
    elif row['Shape_Type'] == "Parallelogram":
        parallelogram = create_Parallelogram(row['ShapeLength'], row['ShapeWidth'], len(j) + 1)
        objects, selected = process_shape(parallelogram, j, k, row['ShapeName'], container)
        objects, selected = process_shape(np.transpose(parallelogram), j, k, row['ShapeName'], container)
    
    elif row['Shape_Type'] == "Rhombus":
        rhombus = create_Parallelogram(row['ShapeLength'], len(j) + 1)
        objects, selected = process_shape(rhombus, j, k, row['ShapeName'], container)
    
    elif row['Shape_Type'] == "Hexagon":
        hexagon = create_Hexagon(row['ShapeLength'], len(j) + 1)
        objects, selected = process_shape(hexagon, j, k, row['ShapeName'], container)
        objects, selected = process_shape(np.transpose(hexagon), j, k, row['ShapeName'], container)
    
    return objects, selected

def add_arrays_with_rotation(container, objects):
    local_object = objects
    while True:
        mask = (container == 0) | (objects == 0)
        if np.all(mask):
            break
        temp = rotate_matrix_right(objects)
        if temp is not None:
                objects = temp
        else:
            temp = shift_matrix_down(local_object)
            local_object = temp
            if temp is not None:
                objects = temp
            else:
                return container
    return container + objects


rectangle = create_Rectangle(5,5,0)
hexagon = create_Hexagon(2,1)
triangle = create_Triangle(3,1)
t_tri = np.transpose(triangle)
f_tri = np.flip(triangle, axis=0)
tf_tri = np.transpose(np.flip(triangle, axis=0))
print(triangle,t_tri,f_tri,tf_tri,sep='\n')
#resize = resize_2d_array(hexagon,rectangle)
#for i in range(len(rectangle[0])):
#    rectangle[0][i] = 2
#    rectangle[1][i] = 2
#add = add_arrays_with_rotation(rectangle, resize)
#print(add)
