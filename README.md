# robot_automation

Project Test with Robot Framework using Page Objects pattern.

3 important flows in Zé Delivery site. I've identified these:

Address Registration: If the user can't enter address, he will not know if the Zé delivery service will be available in his region.   
And if it's available, the products will not be displayed in this case.  

Payment: If the payment services need confirmation by cellphone, the purchase can't be completed and the order can't be created.  

Cart: If the products selected by the user are not being updated and calculated correctly in the cart, it will cause problem in payment.  

I will choose the shopping cart to perform the automated tests.  
I will choose Python programming language because the company use in development.  
I will choose Robot framework because QA use in your tests automation.  

The idea is to do a simple test, for Zé Delivery company, following good practices.
1. Search the product
2. Select product and quantity 
    >> get values
3. Validated values on the shopping cart page:  
    >> validated the product name is same on the shopping cart page.  
    >> validated the price of the product is the same on the shopping cart page.  
    >> validated the sub total value.  
    >> validated the total value.     

 
Plus Feature - Mobile Test (Android Only):  
*** Test Cases ***    
Test scenario - User registration  
Given open test application  
And select create account  
When fill of the user registration And submit user registration  
Then validate phone confirmation screen

Extras:  
- Highlight function.  
- Trigger Function - More performance in different browsers (performance is critical issue in automation).   
    >> When the Framework using the non-visible function is very slow.  
- Tested in Firefox and Chrome.  
- No have sleep e slow option, mode fast.  
- Only one xpath and more IDs.  
- mode headless tested.

**Pending TO DO: 
- pipeline file.
- pages variables and locators in yaml file.
- API testing refactoring.

How to install:
```
 git clone https://github.com/reinaldorossetti/robot_automation_ui.git
 cd robot_automation_ui   
 pip install -r requirements.txt
```

** Setting PYTHONPATH inside project:

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

Web features:
```
robot --loglevel DEBUG:INFO -v BROWSER:Chrome  -d my_reports -i cart_page ./
robot --loglevel DEBUG:INFO -v BROWSER:Firefox -d my_reports -i cart_page ./
robot --loglevel DEBUG:INFO -v BROWSER:headlessfirefox -d my_reports -i cart_page ./
robot --loglevel DEBUG:INFO -v BROWSER:headlesschrome -d my_reports -i cart_page ./
```
Api features:
```
robot --loglevel DEBUG:INFO -d my_reports -i api_tests ./  
```
Mobile features:
```
robot --loglevel DEBUG:INFO -d my_reports -i mobile_tests ./  
```

** Do you need download the drivers to python script folder, compatible with your browser version:  
https://chromedriver.chromium.org/downloads  
https://github.com/mozilla/geckodriver/releases  


Folder Structure Conventions
============================

> Folder structure and naming conventions for my project.

### A typical cucumber directory pattern.
    .
    ├── features                    # Files and folders of framework (root code)
        ├── commons                 # Commons files to tests spec (global use).
        ├── pages                   # Source files page object pattern.
            ├── resources            # Source files to helper pages, the idea is to reduce code.
        ├── steps_definitios        # Step by step of tests.
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
robotframework==3.2.2
robotframework-seleniumlibrary==5.1.0
robotframework-pageobjectlibrary>=1.0.2
pyyaml==3.12

```

References:  
https://pypi.org/project/robotframework-pageobjectlibrary    
https://libraries.io/pypi/robotframework-pageobjectlibrary  
https://github.com/boakley/robotframework-pageobjectlibrary  

Udemy Course >> WEB Testing Avançado >> Follow use the page object:  
https://www.udemy.com/course/automacao-de-testes-com-robot-framework-avancado  
