#!/bin/env coffee
# encoding: utf-8

# Conway's Game of Life by Stephen Boyd, in Coffeescript

generation = 0
width = 60
height = 30

grid1 = [0..width].map (x) ->
  [0..height].map (y) ->
    false

grid2 = [0..width].map (x) ->
  [0..height].map (y) ->
    false

seed = ->
  for y in [1..height-1]
    for x in [1..width-1]
      grid1[x][y] = Math.random() >= 0.5

print_grid = (grid) ->
  buffer = '''\033[42m''' #ANSI code for green color
  for each in [1..40]
    buffer += "\n"
  buffer += "generation: #" + generation + "\n"
  for y in [0..height]
    for x in [0..width]
      if grid[x][y] is true
        buffer += "█"
      else
        buffer += " "
    buffer += "\n"
  console.log buffer
  console.log '''\033[0m'''

generate = (source, target) ->
  generation += 1
  console.log 'generating'
  for y in [1..height-1]
    for x in [1..width-1]
      live_neighbors = 0
      live_neighbors += 1 if source[x-1][y-1] is true
      live_neighbors += 1 if source[x][y-1] is true
      live_neighbors += 1 if source[x+1][y-1] is true
      live_neighbors += 1 if source[x-1][y] is true
      live_neighbors += 1 if source[x+1][y] is true
      live_neighbors += 1 if source[x-1][y+1] is true
      live_neighbors += 1 if source[x][y+1] is true
      live_neighbors += 1 if source[x+1][y+1] is true
      target[x][y] = false
      if source[x][y] is true
        target[x][y] = true if (live_neighbors is 2 || live_neighbors is 3)
      else
        target[x][y] = true if live_neighbors is 3

sleep = (ms) ->
  start = new Date().getTime()
  continue while new Date().getTime() - start < ms

iterate = ->
  if generation % 2 is 0
    generate(grid1, grid2)
    print_grid(grid2)
  else
    generate(grid2, grid1)
    print_grid(grid1)

print_grid(grid1)
seed()

while (1 is 1)
  iterate()
  sleep(400)
