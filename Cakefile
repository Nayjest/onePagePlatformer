exec = require('child_process').exec
spawn = require('child_process').spawn

run = (cmd, cb)->
  exec cmd, (error, stdout, stderr)->
    console.log('stdout: ' + stdout)
    console.log('stderr: ' + stderr)
    if (error != null)
      console.log('exec error: ' + error)
    cb() if cb

task 'build', "Build coffeescripts", ->
  console.log 'compiling coffee...'
  run "coffee -c -o lib src",
    ->
      console.log 'building to one file...'
      run "r.js.cmd -o build.js"

task 'watch', "Watch coffeescripts", ->
  watch = spawn "coffee -cw -o lib src"
  watch.on 'data', (data)->
    console.log data


