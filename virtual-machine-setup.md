# Virtual lab environment

## Prerequisites

### Ubuntu ISO

Download Ubuntu Desktop ISO from https://ubuntu.com/download/desktop.

### VirtualBox

#### macOS

Install [Homebrew](https://brew.sh) if it's not already available.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Install VirtualBox via Homebrew

```bash
brew cask install virtualbox
```

## Setting up the virtual machine

![setup-1](./assets/setup-1.png)

Open up VirtualBox and click on the button labeled `New`.

![setup-2](./assets/setup-2.png)

Give the machine a name and select `Linux` and `Ubuntu (64-bit)` for type and version. The machine folder can be left default.

![setup-3](./assets/setup-3.png)

Give the machine a reasonable amount of memory, such as 4GB on a machine with 16GB in total.

![setup-4](./assets/setup-4.png)

Click through the next few steps to create a virtual hard drive. Leave the defaults.

![setup-5](./assets/setup-5.png)

![setup-6](./assets/setup-6.png)

![setup-7](./assets/setup-7.png)

![setup-8](./assets/setup-8.png)

Click on the newly created virtual machine in the left pane and then on the cog labeled `Settings`.

![setup-9](./assets/setup-9.png)

Navigate to the storage section and click on the `Empty` slot under `Controller: IDE`. Click on the disk icon next to the `IDE Secondary Master` dropdown. Find and select the previously downloaded Ubuntu ISO.

![setup-10](./assets/setup-10.png)

Click on the button labeled `OK` in order to close the window.

![setup-11](./assets/setup-11.png)

Start the machine by clicking on the green arrow labeled `start`. If prompted, select the previously selected Ubuntu ISO and click `Start`.

![setup-12](./assets/setup-12.png)

Click on the button labeled `Install Ubuntu`.

![setup-13](./assets/setup-13.png)

Use the `Detect Keyboard Layout` mode and follow the on-screen directions in order to setup the proper layout.

![setup-14](./assets/setup-14.png)

Select `Minimal installation` and click the button labeled `Continue`.

![setup-15](./assets/setup-15.png)

Select `Erase disk and install Ubuntu` and click `Install Now`.

![setup-16](./assets/setup-16.png)

Click `Continue`

![setup-17](./assets/setup-17.png)

Select your timezone.

![setup-18](./assets/setup-18.png)

Enter the default user's credentials. In this case the username is `pa1450` and the password is `pa1450`. Select `Log in automatically`. The next step will take a few minutes to complete.

![setup-19](./assets/setup-19.png)

Click on the button labeled `Restart Now`. When asked to remove the install medium, press the enter key.

![setup-20](./assets/setup-20.png)

Skip the social login.

![setup-21](./assets/setup-21.png)

Choose the option to not send any information to Canonical. Click on the `Next` button.

![setup-22](./assets/setup-22.png)

Do not enable the location service. Click on the `Next` button.

![setup-23](./assets/setup-23.png)

Press the button labeled `Done`.

![setup-27](./assets/setup-27.png)

If a popup has appeared asking you to update, press `Install Now`.

![setup-28](./assets/setup-28.png)

Wait for the update to finish and click on the button labeled `Restart Now`.

![setup-24](./assets/setup-24.png)

Go back to the main VirtualBox window and click on the list right to the virtual machine's name. Click on the item labeled `Snapshots`.

![setup-25](./assets/setup-25.png)

Click on the button labeled `Take`.

![setup-26](./assets/setup-26.png)

Name the snapshot to `Clean install`. Click the button labeled `OK`. The snapshot allows us to go back to the clean state if we need to later.

## Installing development environment

To install the development environment, execute the script called `setup.sh`.

![setup-32](./assets/setup-29.png)

This is done by first getting the script onto the virtual machine. This is most easily done by first navigating to the script on GitHub, and then pressing the `Raw` button. The URL can then be shortened using a URL shortener and used in the following command on the virtual machine:

```bash
wget https://url-to-setup.sh -O setup.sh
```

_Note: replace `https://url-to-setup.sh` with the actual URL to the script._

You can now run the script by typing

```bash
sudo bash setup.sh
```

Follow the on-screen instructions carefully. Once the script has completed the machine will restart.

![setup-30](./assets/setup-30.png)

Once it has started again, enable clipboard sharing by navigating to the virtual machine's settings and selecting `Bidirectional` for `Shared Clipboard` and `Host To Guest` for `Drag'n'Drop`.

Lastly, create a second snapshot using the same steps as previously. This time call it `Configured`.
