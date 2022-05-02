*** Settings ***
Library         Collections
Library         RequestsLibrary
Variables       ../commons/api_tests/mass_of_data/mass_of_tests.yaml
Resource        ../commons/api_tests/setup.robot
Resource        ../steps_definitions/tasks_weather_steps_call.robot
