### Vagrant box to support Function Development on OCI

This box is designed to provide a fully configured client environment for developing using the Functions capability on OCI. It is delivered as a [Vagrant](https://www.vagrantup.com/) box to help encapsulate all of the utilities and the environment config.

## Quickstart

In order to set up this box for your environment, copy or rename config.sh_sample to config.sh and update it with the values appropriate for your environment (see below for where to get those values), and put your SSH key somewhere in the project directory. This gets mounted to /vagrant in the box, so make sure your key_file property is set appropriately.

Then run `vagrant up` to kick off provisioning. Functions and Docker will be downloaded, and an OCI context will be set up in your fn cli to allow you to deploy and invoke functions directly in OCI.

Once provisioning is complete, connect to the box using `vagrant ssh`, check that the OCI context is created and in use using `fn list contexts`, then test the connection to OCI with `fn list apps`.

To build your first function, navigate to `/vagrant` (I tend to use the shared directory, as then I can work in my normal IDE), and initialise a function with `fn init --runtime (node|java|go|etc.) my-first-fn`

This should create a directory called 'my-first-fn' in your project directory, with a function skeleton in it.

You can then take and deploy that fn to OCI using `fn deploy --app <app-name>` where app-name is an app you have previously created in OCI Functions. You can test invoking that app with `fn invoke <app-name> <function-name>`.

To swap back to working locally, swap back to the default context `fn use context default`.

## Prerequisities

Using Functions in OCI requires some initial setup to be performed on the OCI side, to create a repository for the function images, setting up networking, as well as adding a Functions environment to your compartment.

In order to do this, I recommend you follow the instructions available in the offical documentation, [here](https://docs.cloud.oracle.com/en-us/iaas/Content/Functions/Concepts/functionsprerequisites.htm). This environment is designed to provide a pre-packaged client environment, so there is no need to follow the steps in 'Configuring Your Client Environment for Function Development'.

## About the Configuration Values

The configuration of this environment requires information about your tenancy, and information about the user.

Tenancy Information:

* tenancy_id - This is the tenancy ocid from the tenancy information page.
* compartment_name - The name of the compartment in which your Functions environment is created
* compartment_id - The ocid of this compartment
* region - The region code i.e. ap-sydney-1, which you can obtain from the OCI url
* registry - The tenancy OCIR namespace
* repo - The name of your repository in the OCIR registry

User Information:

* user - Your username for accessing OCI. If the user is federated, it will be of the form oracleidentitycloudservice/my.federated.user
* user_ocid - The ocid of this user
* key_fingerprint - The key fingerprint of an API key associated with this user
* key_file - The path to the private key in the Vagrantbox associated with the above key fingerprint
* key_passphrase - A passphrase for the private key, if it is encrypted. Leave empty, but don't delete this line if it is not encrypted
* token - The value of an Auth token associated with this user (this is used to log into the OCIR)

If you need to change one of these values after provisioning, you can update the value in the config.sh file, then run the scripts `configure-oci.sh` and `configure-fn.sh` located in `/vagrant/scripts` to propagate the configuration changes.