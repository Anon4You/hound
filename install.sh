#!/data/data/com.termux/files/usr/bin/env bash

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# Function to check if a package is installed
is_installed() {
    if command -v "$1" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Install required packages
install_packages() {
    echo -e "${BLUE}Checking and installing required packages...${NC}"

    # Install Git
    if ! is_installed "git"; then
        echo -e "${YELLOW}Git is not installed. Installing Git...${NC}"
        apt install -y git
        echo -e "${GREEN}Git installed successfully.${NC}"
    else
        echo -e "${CYAN}Git is already installed.${NC}"
    fi

    # Install PHP
    if ! is_installed "php"; then
        echo -e "${YELLOW}PHP is not installed. Installing PHP...${NC}"
        apt install -y php
        echo -e "${GREEN}PHP installed successfully.${NC}"
    else
        echo -e "${CYAN}PHP is already installed.${NC}"
    fi

    # Install Node.js (required for tunnelmole)
    if ! is_installed "node"; then
        echo -e "${YELLOW}Node.js is not installed. Installing Node.js...${NC}"
        apt install -y nodejs
        echo -e "${GREEN}Node.js installed successfully.${NC}"
    else
        echo -e "${CYAN}Node.js is already installed.${NC}"
    fi

    # Install Tunnelmole
    if ! is_installed "tunnelmole"; then
        echo -e "${YELLOW}Tunnelmole is not installed. Installing Tunnelmole...${NC}"
        npm install -g tunnelmole
        echo -e "${GREEN}Tunnelmole installed successfully.${NC}"
    else
        echo -e "${CYAN}Tunnelmole is already installed.${NC}"
    fi
}

# Clone the repository
clone_repo() {
    echo -e "${BLUE}Cloning the repository...${NC}"
    if [ -d "$PREFIX/share/hound" ]; then
        echo -e "${CYAN}Repository already exists at $PREFIX/share/hound. Updating...${NC}"
        cd "$PREFIX/share/hound" && git pull
    else
        git clone https://github.com/Anon4You/hound.git "$PREFIX/share/hound"
        echo -e "${GREEN}Repository cloned successfully.${NC}"
    fi
}

# Create the hound executable
create_executable() {
    echo -e "${BLUE}Creating hound executable...${NC}"
    cat << EOF > "$PREFIX/bin/hound"
#!/data/data/com.termux/files/usr/bin/env bash
cd "$PREFIX/share/hound"
bash hound.sh
EOF

    # Make the executable file executable
    chmod +x "$PREFIX/bin/hound"
    echo -e "${GREEN}Executable 'hound' created in $PREFIX/bin.${NC}"
}

# Main script
main() {
    echo -e "${GREEN}Starting installation...${NC}"

    # Install required packages
    install_packages

    # Clone the repository
    clone_repo

    # Create the hound executable
    create_executable

    echo -e "${GREEN}Installation complete! You can now run 'hound' to start the tool.${NC}"
}

# Run the main function
main
