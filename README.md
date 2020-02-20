# nodejs_app_ami

TODO: Enter the cookbook description here.

This cookbook was created in the aim of having all the dependencies required to run the node sample app and then to create an ami using packer.

## Cookbook
This cookbook was created using chef `chef generate cookbook nodejs_app_ami` and it contains the dependencies in the recipe needed to run the node sample app. It also contains a Berksfile which has the chef supermarket and the metadata and is used to manage the dependencies of the cookbook and a berks-cookbooks `berks vendor`. It also has a proxy.conf used to create a reverse proxy.

## Packer
Packer is used to create immutable images of our machines. I used packer to create an AMI in AWS. I specified the configuration of this in the packer.json where I also copied the file containing the app into the image. Now if you start an instance using the ami you can also run the app

## Running the app using an image generated from packer
You first need to create an image. To do this when in the nodejs_app_ami folder, in the command line type:
```
packer build packer.json
```
Launch an instance using the ami created, name of ami is specified in the packer.json folder

When instance has been created enter the machine using the key(key_name.pem) specified in packer.json and the ip address(xxx.xxx.xxx.xxx) generated. In the command line type:
```
ssh -i ~/location/of/key/key_name.pem ubuntu@xxx.xxx.xxx.xxx
```
Enter the app directory
```
cd app
```
Start the app
```
node app.js
```
To use the app type in the ip address in the web browser and also go to port 3000(xxx.xxx.xxx.xxx:3000)
