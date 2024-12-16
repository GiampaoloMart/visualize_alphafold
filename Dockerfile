# Start from a Python 3.8 image
FROM python:3.8-slim-buster

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    MPLCONFIGDIR=/tmp/matplotlib

# Install system dependencies, including procps for the 'ps' command
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    jax \
    jaxlib \
    matplotlib \
    numpy \
    joblib \
    memory_profiler \
    pandas \
    seaborn \
    scikit-learn

# Set up matplotlib configuration directory
RUN mkdir -p $MPLCONFIGDIR && chmod 777 $MPLCONFIGDIR

# Set the working directory
WORKDIR /app

# The CMD instruction provides defaults for an executing container
CMD ["python"]
