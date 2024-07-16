# Llamagator

![alt text](/public/logo.png)

Welcome to Llamagator! This project is built using Ruby on Rails and is designed to be easily set up using Docker Compose.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Llamagator is a web application built with Ruby on Rails 7.1.3, designed to provide a seamless experience for managing your LLM's. The application uses PostgreSQL 14 as its database.

## Features

- **Model and Model Versions Creation:**
  Create different models and versions of models within the application.
  
- **Configuration Management:**
  Set configurations for models and their versions, allowing for customized settings.
  
- **Prompts Creation:**
  Create prompts which define actions or tasks to be executed.
  
- **Prompt Execution:**
  Execute prompts using any specified models and model versions.
  
- **Result Rating and Comparison:**
  Rate and compare the results obtained from running prompts, facilitating evaluation and analysis.

## Getting Started

### Usage

To get started with Llamagator, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/aifoundry-org/llamagator.git
   cd llamagator

2. **Build and start the containers:**

   ```bash
   docker compose up

3. **Access the application:**

   Open your browser and navigate to http://localhost:3000.

## Contributing

We welcome contributions from the community! If you'd like to contribute to Llamagator, please follow these steps:

1. Fork the repository on GitHub.
2. Create a new branch with a descriptive name for your feature or bug fix.
3. Make your changes and commit them with a clear message.
4. Push your changes to your fork.
5. Create a pull request on the original repository's GitHub page.

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.
