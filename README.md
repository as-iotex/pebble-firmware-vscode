# Pebble firmware dev container

This repository provides a container with the pre requisites for building and developing firmware for the IoTeX Pebble tracker.  
The aries pebble application is included as a submodule so it can be optionally downloaded along with the dev container.   

## Getting started in VS Code

### Initialise the container

1. Clone the repository. Use the `--recursive` flag when cloning the repository if you want to clone the aries application.  If you don't use the recursive flag only the generic environemnt will be cloned, and you can create a new applicatin from scratch (explained below).  
2. Open the folder where you have cloned this repository in VS Code.  
3. Install the `Remote: Containers` VS Code extension if you don't already have it installed.  
4. Press `F1` to open the command panel. Then type `Containers: Reopen in container`.  
5. The VS Code window will reaload and initialize the container. Wait for this step to finish, it may take a few minutes.  

> :information_source: **NOTE:**  
By default VS Code will bind mount your workspace directory to the devcontainer. This means that if you clone the aries firmware as a submodule, you will be able to view the files while VS Code is connected remotely to the container. Code navigation, debugging, editing files will work seamlessly.  

### Setup the NRF Connect extension and create your application

Once the container is initialised, it should have installed the `NRF Connect` extension. 
You should be able to see it see it in the left side panel. If you can't, check your extensions panel and enable the NRF Connect extension.  

![image](https://user-images.githubusercontent.com/82106612/178300632-44cab4fa-9484-4872-90a4-c91e5ef3fc04.png)  

Click on the NRF Connect icon to open the extension view:  

![image](https://user-images.githubusercontent.com/82106612/178300755-517ebc3b-a556-41e8-a76e-a172d7bf3c3a.png)


#### Add an existing application (if you have cloned aries)

If you already have an existing application and want to add it to your workspace. Follow the next steps:  
1. Click on `Add an existing application` on the NRF Connect side panel.  
2. If you have cloned pebble-firmware, then you should see a directory named `pebble-firmware`.  
3. Navigate to `pebble-firmware/nrf/applications/Aries/` and press `OK`.  
4. A new panel on the right named `Applications` will be created containing the Aries application.  

![image](https://user-images.githubusercontent.com/82106612/178300912-92ad4a47-e78f-4528-923d-7e122eb39706.png)


#### Create a new application from a template

1. Open the NRF Connect extension panel and click `Create a new application`.  
2. Select the applicaiton template you want to use.  
3. Change application name and location or use the default ones.  
4. Click `Create application`.  

![image](https://user-images.githubusercontent.com/82106612/178301566-bcd153b6-79a1-4199-a266-2b2ad5513ea9.png)

Now you should be able to see your application under the Applications tab

![image](https://user-images.githubusercontent.com/82106612/178301635-5ceaae76-a16c-4c40-819c-6957c98b6e1e.png)


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

![image](https://user-images.githubusercontent.com/82106612/178301753-21383cc0-41f6-4083-9212-7ab55dfe7cb5.png)


The app build will start, you can see the build progress in your terminal.  

#### Build output

The build files will be paced inside your build directory (spcified when creating the build configuration).  
The application hex file will be at `<build_directory/zephyr/app_test_update.hex>`.  

![image](https://user-images.githubusercontent.com/82106612/178304048-c5a92efd-acbb-406d-a775-0071ee436fb2.png)

