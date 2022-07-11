# Pebble firmware dev container

This repository provides a container with the pre requisites for building and developing firmware for the IoTeX Pebble tracker.  
The aries pebble application is included as a submodule.  

## Getting started in VS Code

### Initialise the container

1. Clone the repository. Use the `--recursive` flag when cloning the repository if you want to clone the aries application.  If you don't use the recursive flag only the generic environemnt will be cloned, and you can create a new applicatin from scratch (explained below).  
2. Open the folder where you have cloned this repository in VS Code.  
3. Install the `Remote: Containers` VS Code extension if you don't already have it installed.  
4. Press `F1` to open the command panel. Then type `Containers: Reopen in container`.  
5. The VS Code window will reaload and initialize the container. Wait for this step to finish, it may take a few minutes.  

### Setup the NRF Connect extension and create your application

Once the container is initialised, it should have installed the `NRF Connect` extension. You should be able to see it see it in the left side panel. Click on the icon to open the extension view.  

#### Add an existing application (if you have cloned aries)

If you already have an existing application and want to add it to your workspace. Follow the next steps:  
1. Click on `Add an existing application` on the NRF Connect side panel.  
2. If you have cloned pebble-firmware, then you should see a directory named `pebble-firmware`.  
3. Navigate to `pebble-firmware/nrf/applications/Aries/` and press `OK`.  
4. A new panel on the right named `Applications` will be created containing the Aries application.  

#### Create a new application from a template

1. Open the NRF Connect extension panel and click `Create a new application`.  
2. Select the applicaiton template you want to use.  
3. Change application name and location or use the default ones.  
4. Click `Create application`.  

Now you should be able to see your application under the Applications tab

### Build the application

#### Create a build configuration

In order to build the application you need to create a build configuration.  
You can have several build configurations for the same application. This can happen for example if you want to use the applicaiton in different boards.  

Follow the next steps to create a build configuration for pebble tracker. Change the board if you would like to use a different board:  
1. Click the `Add build configuration button` on your existent app.  
2. Select the `Nordic boards` radio button.  
3. Select `iotex_pebble_hw30ns` from the dropdown.  
4. Change the build directory name if you wish.  
5. Click `Build Configuration`.  

The app build will start, you can see the build progress in your terminal.  

#### Build output

The build files will be paced inside your build directory (spcified when creating the build configuration).  
The application hex file will be at `<build_directory/zephyr/app_test_update.hex>`.  