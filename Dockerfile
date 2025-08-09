# FROM ollama/ollama:latest

# RUN apt-get update 
# RUN pip install jupyter notebook
# RUN pip install ollama
FROM ollama/ollama:latest

# Install Python 3 and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    rm -rf /var/lib/apt/lists/*

# Create and activate a virtual environment
RUN python3 -m venv /opt/venv

# Install packages in the virtual environment
RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install jupyter notebook ollama

# Make sure the virtual environment is used by default
ENV PATH="/opt/venv/bin:$PATH"

# Set the working directory
WORKDIR /workspace

# Copy all files into the container
COPY . /workspace

# Expose Jupyter Notebook port
EXPOSE 8888

# Start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--NotebookApp.token=''"]
