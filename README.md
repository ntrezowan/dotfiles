This Brewfile installs all the necessary packages (according to me) required after getting a freshly installed MacOS.

---

### How to install packages

1. Install Homebrew
    ```shell
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
2. Clone the repo
    ```shell
    git clone https://github.com/ntrezowan/workstation-config.git
    cd workstation-config
    ```
2. Install Bundle
    ```shell
    brew bundle install
    ```
3. Remove packages not installed from Brewfile
    ```shell
    brew bundle --force cleanup
    ```

---

### How to enable automatic package update

1. Enable Brew auto update
    ```shell
    brew tap homebrew/autoupdate
    ```

2. Check status
    ```shell
    brew autoupdate status
    ```


# Custom configurations

1. MacOS by default has a setting of `hibernatemode=3` but this setting keeps providing power to attached USB device when it sleeps. To avoid this -

    ```shell
    sudo pmset -a hibernatemode 25
    ```
2. Alacritty terminal font renders as bold and to avoid this -

    ```shell
    defaults write org.alacritty AppleFontSmoothing -int 0
    ```

3. Check Battery health

    Run the following 
    
    ```shell
    ioreg -l -w0 | grep Capacity
        | |           "AppleRawCurrentCapacity" = 7556
        | |           "AppleRawMaxCapacity" = 7969
        | |           "MaxCapacity" = 7969
        | |           "CurrentCapacity" = 7556
        | |           "LegacyBatteryInfo" = {"Amperage"=1045,"Flags"=7,"Capacity"=7969,"Current"=7556,"Voltage"=12997,"Cycle Count"=111}
        | |           "BatteryData" = {"StateOfCharge"=95,"PMUConfigured"=896,"CellVoltage"=(4340,4326,4332),"AdapterPower"=1107308657,"Serial"="D861435N2WLFWLKHV","SystemPower"=6844,"LifetimeData"={"UpdateTime"=1737996732},"DesignCapacity"=8755,"CycleCount"=111,"Voltage"=13022,"Qmax"=(9143,9121,9130)}
        | |           "DesignCapacity" = 8755
    ```
    
    State of Charge = AppleRawCurrentCapacity/AppleRawMaxCapacity
   
    State of Health = AppleRawMaxCapacity/DesignCapacity
