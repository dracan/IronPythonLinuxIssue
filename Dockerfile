FROM microsoft/dotnet:2.0-sdk

# Install Python
RUN apt update -y \
    && apt dist-upgrade -y \
    && apt install python2.7 python-pip -y

# Install Mono
RUN apt install apt-transport-https dirmngr -y \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/debian stable-stretch main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt update -y \
    && apt install mono-devel -y

WORKDIR /app

# Copy IronPython files and our Python scripts into the image
COPY . .

# Build the IronPython DLL from our Python scripts
RUN mono ./IronPython/ipy.exe ./CompileIntoDll.py
