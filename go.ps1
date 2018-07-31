# Build the Docker image, which will also convert the Python script into an IronPython DLL
docker build . -t ironpythonlinuxissuetest

# Copy the compiled IronPython DLL out of the Docker container
docker run -v ${PWD}/Output:/app/Output ironpythonlinuxissuetest:latest sh -c "cp /app/CompiledPython.dll /app/Output/CompiledPython.dll"

# Try to run the script with C# (using LINQPad)
lprun RunCompiledRoutine.linq ${PWD}\Output\CompiledPython.dll
