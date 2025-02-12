# Contributing Template Branches to Craft-Templates

Thank you for considering contributing a new template branch to the Craft Tool! This guide explains what you need to include in your template branch, how to structure your files, and the naming conventions required for branch names in the [craft-templates repo](https://github.com/VincentVanCode101/craft-templates).

> **Important:**  
> Everywhere in your template files where the final project’s name should appear, use the placeholder `{PROJECT_NAME}`. The Craft Tool will automatically replace `{PROJECT_NAME}` with the actual project name during project generation.

---

## What Your Template Must Include

Your template should provide a ready-to-use project setup for a given language and build level (e.g., _build_ or _prod_), with or without additional dependencies. At a minimum, your template must include the following files:

1. **`create.sh`**  
   - **Purpose:** This is the entry point for the template. When a user runs `create.sh`, it should perform all the necessary steps so that the only thing left is a fully configured project.
   - **Expectation:** After executing `create.sh`, the generated project should be ready for use—no further manual configuration is required.

2. **Dockerfile(s)**  
   - **Purpose:** Provide Dockerfiles that support your template’s build and/or production requirements.
   - **Examples:**
     - A builder Dockerfile (e.g., based on `maven`, `golang`, `rust`, etc.) for generating or compiling the project.
     - A development Dockerfile that can be used to run tests and start the application in a development environment.
   - **Level Considerations:**  
     - For **build** or **prod** templates, your Dockerfile(s) must do more than just provide a runtime. They should support full build and/or production workflows—either through a multi-stage Dockerfile or by providing multiple Dockerfiles that separate the build and runtime stages.

3. **`docker-compose.dev.yml`**  
   - **Purpose:** Sets up the development environment. This file should define services (containers), volumes, ports, and any environment variables needed.
   - **Usage Instructions:** In the generated project’s README, explain to the user how to use this file (e.g., how to build and run the container).

4. **`make` Script**  
   - **Purpose:** Provide a set of commands for building, testing, running, cleaning, and packaging the project.
   - **Expected Commands:**
     - **`build`**: Compile the project (or specific source files).
     - **`run`**: Run the main application (or a specified file).
     - **`test`**: Run tests.
     - **`clean`**: Clean build artifacts.
     - etc.
   - **Usage Instructions:** The generated README should detail how to invoke these commands within the development container.

5. **`README.md` (for the generated project)**  
   - **Purpose:** This README is intended for end users who generate a project using your template.
   - **Content Should Include:**
     - An overview of the project.
     - Instructions on how to build and start the Docker development environment (using the provided `docker-compose.dev.yml` file)(Or depending on the level how to start the build || prod level docker containers).
     - Steps to connect to the development container (or build / prod containers) (e.g., using `docker exec -it {xxx} bash`).
     - How to use the Make script commands (e.g., `./make build`, `./make test`, `./make run`, etc.).
     - Any additional configuration or dependency-related notes that the user should be aware of.

---

## Repository Structure Example

Your template branch should have a structure similar to this:

```
.
├── create.sh                  # Entry point for generating the project
├── Dockerfile                 # (Or multiple Dockerfiles as needed)
├── docker-compose.dev.yml     # Development environment configuration
├── make                       # Make script (executable) for build/test/run tasks
├── README.md                  # Documentation for the generated project
└── ...                        # Any additional scripts or configuration files
```

---

> **Note:** Please review the [helpers](./helpers) folder, which contains useful scripts that many templates already leverage in their create.sh to streamline project generation..

## Level-Specific Requirements

- **Dev Level (Default):**  
  If no level is specified in the template key, the default level is assumed to be `dev`. A dev-level template should provide a basic language runtime environment suitable for development.

- **Build/Prod Levels:**  
  If you are contributing a template for a `build` or `prod` level, you **must** include a `docker-compose.yml` file (or similarly named configuration file) that sets up the complete environment for building or production deployment.  
  Additionally, your Dockerfile(s) for build or prod levels must do more than just supply a runtime—they should support full build and/or production workflows. This can be achieved by:
  - Providing a multi-stage Dockerfile that handles both building and packaging the application.
  - Offering multiple Dockerfiles that separate the build and runtime stages.

---

## Branch Naming Conventions

Templates are identified by a **templates key** which is constructed by joining the language, an optional level (`build` or `prod`), and any dependencies (sorted alphabetically) with underscores.

### Key Construction

- **Default Level:**  
  If no level is specified, the key is just the language (e.g., `go`).

- **Explicit Level:**  
  If a level is provided, the key becomes `language_level` (e.g., `go_prod`, `java_build`).

- **With Dependencies:**  
  Append sorted (alphabetically) dependencies to the key (e.g., `go_prod_mariadb_ncurs`).

> **Important:** This constructed templates key **must** be the name of the branch in the [craft-templates repo](https://github.com/VincentVanCode101/craft-templates).

Make sure that your branch name in the repository exactly matches the constructed key.

---

## Contributing Process

> **Note:** Before submitting your template, please take a look at the existing templates in the repository, as they all adhere to these standards and can serve as valuable examples.


1. **Fork and Create a Branch:**  
   - Fork the [craft-templates repo](https://github.com/VincentVanCode101/craft-templates) and create a new branch named according to the templates key (e.g., `java_build`, `go_prod_mysql`, `python_build_fastapi`, etc.).

2. **Implement the Template:**  
   - Populate your branch with all the required files and follow the structure outlined above.
   - Ensure that every instance of the project name is denoted by `{PROJECT_NAME}`.

3. **Test Your Template:**  
   - Run your `create.sh` locally to verify that it generates a complete and functional project.
   - Double-check that the generated README provides clear instructions for end users on how to use Docker, the Make script, and any other provided tools.

4. **Submit a Pull Request:**  
   - Once your template is ready and tested, submit a pull request with a clear description of your changes and instructions for users.

---

Thank you for contributing to the Craft Tool template collection! Your efforts help make it easier for others to quickly generate and start projects in their preferred language and environment.