define [
  'components/Vector2D/Vector2D',
], (
  Vector2D
)->
  ###
  Game map
  limitations: 1 object per grid cell
  ###
  class Map
    constructor: (grid, objDictionary, construct)->
      @size = new Vector2D grid[0].length, grid.length
      @grid = []
      @objects = []
      for row, y in grid
        @grid.push []
        for code, x in row
          if objDictionary[code]
            obj = construct objDictionary[code], new Vector2D(x, y), @
            @grid[y][x] = obj
            @objects.push obj

    getObjectsByDist: (pos, dist=1)->
      objects = []
      minX = Math.max 0, pos.x - dist
      maxX = Math.min @size.x-1, pos.x + dist
      minY = Math.max 0, pos.y - dist
      maxY = Math.min @size.y-1, pos.y + dist
      for y in [minY..maxY]
        if @grid[y]
          for x in [minX..maxX]
            if @grid[y][x]
              objects.push @grid[y][x]
      objects
