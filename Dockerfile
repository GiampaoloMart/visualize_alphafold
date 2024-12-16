# Start from a Python 3.8 image
FROM python:3.8-slim-buster

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    MPLCONFIGDIR=/tmp/matplotlib

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    procps \
    openjdk-11-jre-headless \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    numpy==1.24.3 \
    matplotlib \
    Pillow \
    scipy \
    pandas \
    seaborn \
    scikit-learn \
    joblib \
    memory_profiler \
    jaxlib==0.3.25 -f https://storage.googleapis.com/jax-releases/jax_releases.html \
    jax==0.3.25 -f https://storage.googleapis.com/jax-releases/jax_releases.html

# Set up matplotlib configuration directory
RUN mkdir -p $MPLCONFIGDIR && chmod 777 $MPLCONFIGDIR

# Set the working directory
WORKDIR /app

# Default command for the container
CMD ["python"]
