*** Settings ***
Library         Collections
Library         RequestsLibrary
Variables       ../resources/data/mass_of_tests.yaml
Resource        ../support/setup.robot
Resource        ../steps_definitions/tasks_weather_steps_call.robot
