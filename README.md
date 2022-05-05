# robot_automation

Project Test with Robot Framework using behave directory pattern .

How to install:
```
 git clone https://github.com/reinaldorossetti/robot_automation_ui.git
 cd robot_automation_ui   
 pip install -r requirements.txt
```

** Setting PYTHONPATH inside project (python problem only):

Windows:
```
set PYTHONPATH=%PYTHONPATH%;.;
```
Linux: 
```
export PYTHONPATH=%PYTHONPATH%;.;
```
** If Set PYTHONPATH need set python path in SO system path variables.

Command line to runner:

Api features:
```
python -m robot --loglevel DEBUG:INFO -d my_reports -i api_tests ./  
```
Comando diretamente pelo robot.
```
robot --loglevel DEBUG:INFO -d my_reports -i api_tests ./  
```
Rodando o report local:
```
python -m robot --listener allure_robotframework --rerunfailed my_reports/output.xml -d my_reports -i api_tests ./ 
allure generate ./output/allure -o allure-results/
allure serve
```

Link do Report pelo Git Actions:
https://reinaldorossetti.github.io/robot_openweather_api/allure-results/

Folder Structure Conventions
============================

> Folder structure and naming conventions for my project.

### A typical cucumber directory pattern.
    .
    ├── features                    # Files and folders of framework (root code).
        ├── resources               # Json ou YAML files.
        ├── support                 # Commons files to tests spec (global use).
        ├── steps_definitios        # Keywords of tests.
        ├── specifications          # Specification of what the tests should do and runner of tests.
    ├── .gitignore                  # Files and Folders to ignore in repository.
    ├── LICENSE
    ├── README.md                   # Documentation of project.
    └── requirements.txt            # Libraries to need to install.

> Use short lowercase names at least for the top-level files and folders except  
> `LICENSE`, `README.md`, in folder pages the name of pages follow Camel Case.  

> Use yaml file to store as environment variables and locators, used in the robot files.  
> The project follow Pycharm Python static code analysis tool which looks for programming errors.  
> The Variables that are not mutable must follow upcase in python by default.  

** This project follow the best pratices, below refences of the same.

Dependencies of project:
```
robotframework-requests
robotframework==5.0.0
robotframework-faker
pyyaml>=5.4
```

References:  
https://pypi.org/project/robotframework-pageobjectlibrary    
https://libraries.io/pypi/robotframework-pageobjectlibrary  
https://github.com/boakley/robotframework-pageobjectlibrary  

Udemy Course >> WEB Testing Avançado >> Follow use the page object:  
https://www.udemy.com/course/automacao-de-testes-com-robot-framework-avancado  
