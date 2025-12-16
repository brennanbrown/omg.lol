#!/bin/bash

# Key Generation Script for omg.lol
# Interactive version - generates PGP, SSH, age, Cosign, and Minisign keys
# Repository: https://github.com/brennanbrown/omg.lol

# To use it:
# Download and run
# curl -o generate-keys.sh https://your-omg-lol-url/generate-keys.sh
# chmod +x generate-keys.sh
# ./generate-keys.sh

# Or, as a one-liner:
# bash <(curl -s https://your-omg-lol-url/generate-keys.sh)

set -e
set -o pipefail

umask 077

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

clear

cat << "EOF"
╔═════════════════════════════════════════════════════════════╗
║                                                             ║
║   ██████╗ ███╗   ███╗ ██████╗     ██╗      ██████╗ ██╗      ║
║  ██╔═══██╗████╗ ████║██╔════╝     ██║     ██╔═══██╗██║      ║
║  ██║   ██║██╔████╔██║██║  ███╗    ██║     ██║   ██║██║      ║
║  ██║   ██║██║╚██╔╝██║██║   ██║    ██║     ██║   ██║██║      ║
║  ╚██████╔╝██║ ╚═╝ ██║╚██████╔╝    ███████╗╚██████╔╝███████╗ ║
║   ╚═════╝ ╚═╝     ╚═╝ ╚═════╝     ╚══════╝ ╚═════╝ ╚══════╝ ║
║                                                             ║
║              Cryptographic Key Generator                    ║
║                                                             ║
╚═════════════════════════════════════════════════════════════╝

EOF

echo -e "${CYAN}This script will help you generate all the keys you need for omg.lol!${NC}"
echo -e "${CYAN}We'll create: PGP, SSH, age, Cosign, and Minisign keys.${NC}\n"

# Prompt for email
echo -e "${YELLOW}Please enter your email address:${NC}"
read -p "Email: " EMAIL

if [[ ! "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo -e "${RED}Invalid email format. Please try again.${NC}"
    exit 1
fi

echo -e "\n${GREEN}✓ Email set to: $EMAIL${NC}\n"

# Confirm omg.lol address
echo -e "${YELLOW}Is this for your omg.lol address? (y/n)${NC}"
read -p "> " IS_OMG_LOL

KEY_DIR="$HOME/.cryptographic-keys"
if [[ "$IS_OMG_LOL" =~ ^[Yy]$ ]]; then
    KEY_DIR="$HOME/.omg-lol-keys"
fi

# Ask about key directory
echo -e "\n${YELLOW}Keys will be stored in: ${CYAN}$KEY_DIR${NC}"
echo -e "${YELLOW}Is this okay? (y/n)${NC}"
read -p "> " DIR_CONFIRM

if [[ ! "$DIR_CONFIRM" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Enter custom directory path:${NC}"
    read -p "> " CUSTOM_DIR
    KEY_DIR="${CUSTOM_DIR/#\~/$HOME}"
fi

OUTPUT_FILE="$KEY_DIR/public-keys.md"

# Create directory
mkdir -p "$KEY_DIR"

# Check OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    PACKAGE_MANAGER="brew"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt &> /dev/null; then
        PACKAGE_MANAGER="apt"
    elif command -v yum &> /dev/null; then
        PACKAGE_MANAGER="yum"
    elif command -v pacman &> /dev/null; then
        PACKAGE_MANAGER="pacman"
    else
        echo -e "${RED}Could not detect package manager. Please install dependencies manually.${NC}"
        exit 1
    fi
else
    echo -e "${RED}Unsupported OS. This script works on macOS and Linux.${NC}"
    exit 1
fi

echo -e "\n${BLUE}════════════════════════════════════${NC}"
echo -e "${BLUE}  Checking Dependencies...${NC}"
echo -e "${BLUE}════════════════════════════════════${NC}\n"

# Function to install package
install_package() {
    local package=$1
    echo -e "${YELLOW}Installing $package...${NC}"
 
    set +e
    case $PACKAGE_MANAGER in
        brew)
            brew install "$package" ;;
        apt)
            sudo apt update && sudo apt install -y "$package" ;;
        yum)
            sudo yum install -y "$package" ;;
        pacman)
            sudo pacman -S --noconfirm "$package" ;;
    esac

    local status=$?
    set -e
    return $status
}

# Check for Homebrew on macOS
if [[ "$PACKAGE_MANAGER" == "brew" ]] && ! command -v brew &> /dev/null; then
    echo -e "${RED}Homebrew is required but not installed.${NC}"
    echo -e "${YELLOW}Install from: https://brew.sh${NC}"
    echo -e "${YELLOW}Would you like me to open the website? (y/n)${NC}"
    read -p "> " OPEN_BREW
    if [[ "$OPEN_BREW" =~ ^[Yy]$ ]]; then
        open "https://brew.sh"
    fi
    exit 1
fi

# Check and install dependencies
DEPS=("gpg:gnupg" "ssh-keygen:openssh" "age-keygen:age" "cosign:cosign" "minisign:minisign")

for dep in "${DEPS[@]}"; do
    cmd="${dep%%:*}"
    pkg="${dep##*:}"
    
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${YELLOW}$cmd not found.${NC}"
        echo -e "${YELLOW}Install $pkg? (y/n)${NC}"
        read -p "> " INSTALL
        
        if [[ "$INSTALL" =~ ^[Yy]$ ]]; then
            if install_package "$pkg"; then
                echo -e "${GREEN}✓ Installed $pkg${NC}"
            else
                echo -e "${RED}Failed to install $pkg. Some keys won't be generated.${NC}"
            fi
        else
            echo -e "${RED}Skipping $pkg. Some keys won't be generated.${NC}"
        fi
    else
        echo -e "${GREEN}✓ $cmd found${NC}"
    fi
done

echo -e "\n${GREEN}Dependency check complete!${NC}\n"

# Ask which keys to generate
echo -e "${BLUE}════════════════════════════════════${NC}"
echo -e "${BLUE}  Key Selection${NC}"
echo -e "${BLUE}════════════════════════════════════${NC}\n"

echo -e "${CYAN}Which keys would you like to generate?${NC}"
echo -e "${YELLOW}(Press Enter to generate all, or type numbers separated by spaces)${NC}\n"
echo "  1) PGP (GPG)"
echo "  2) SSH (Ed25519)"
echo "  3) age"
echo "  4) Cosign"
echo "  5) Minisign"
echo ""
read -p "> " KEY_SELECTION

# Default to all if empty
if [[ -z "$KEY_SELECTION" ]]; then
    KEY_SELECTION="1 2 3 4 5"
fi

# Initialize markdown output
cat > "$OUTPUT_FILE" << EOF
# Public Cryptographic Keys

Generated on: $(date)
Email: $EMAIL

---

EOF

KEYS_GENERATED=0

# 1. Generate PGP Key
if [[ "$KEY_SELECTION" =~ "1" ]] && command -v gpg &> /dev/null; then
    echo -e "\n${BLUE}[PGP] Generating PGP key...${NC}"
    
    if gpg --list-secret-keys "$EMAIL" &> /dev/null; then
        echo -e "${YELLOW}PGP key already exists for $EMAIL${NC}"
        echo -e "${YELLOW}Use existing key? (y/n)${NC}"
        read -p "> " USE_EXISTING
        
        if [[ ! "$USE_EXISTING" =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}Skipping PGP key generation${NC}"
        fi
    else
        echo -e "${CYAN}Generating new PGP key (this may take a moment)...${NC}"
        if ! gpg --batch --pinentry-mode loopback --passphrase '' --quick-generate-key "$EMAIL" rsa4096 default 0; then
            gpg --quick-generate-key "$EMAIL" rsa4096 default 0
        fi
    fi
    
    PGP_KEY=$(gpg --armor --export "$EMAIL")
    cat >> "$OUTPUT_FILE" << EOF
## PGP Key

\`\`\`
$PGP_KEY
\`\`\`

---

EOF
    echo -e "${GREEN}✓ PGP key generated${NC}"
    ((KEYS_GENERATED+=1))
fi

# 2. Generate SSH Key
if [[ "$KEY_SELECTION" =~ "2" ]] && command -v ssh-keygen &> /dev/null; then
    echo -e "\n${BLUE}[SSH] Generating SSH key...${NC}"
    
    SSH_KEY_PATH="$KEY_DIR/id_ed25519"
    
    if [ -f "$SSH_KEY_PATH" ]; then
        echo -e "${YELLOW}SSH key already exists at $SSH_KEY_PATH${NC}"
        echo -e "${YELLOW}Overwrite? (y/n)${NC}"
        read -p "> " OVERWRITE
        
        if [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}Using existing SSH key${NC}"
        else
            ssh-keygen -t ed25519 -C "$EMAIL" -f "$SSH_KEY_PATH" -N ""
        fi
    else
        ssh-keygen -t ed25519 -C "$EMAIL" -f "$SSH_KEY_PATH" -N ""
    fi
    
    SSH_KEY=$(cat "${SSH_KEY_PATH}.pub")
    cat >> "$OUTPUT_FILE" << EOF
## SSH Key (Ed25519)

\`\`\`
$SSH_KEY
\`\`\`

---

EOF
    echo -e "${GREEN}✓ SSH key generated${NC}"
    ((KEYS_GENERATED+=1))
fi

# 3. Generate age Key
if [[ "$KEY_SELECTION" =~ "3" ]] && command -v age-keygen &> /dev/null; then
    echo -e "\n${BLUE}[age] Generating age key...${NC}"
    
    AGE_KEY_PATH="$KEY_DIR/age-key.txt"
    
    if [ -f "$AGE_KEY_PATH" ]; then
        echo -e "${YELLOW}age key already exists${NC}"
        echo -e "${YELLOW}Overwrite? (y/n)${NC}"
        read -p "> " OVERWRITE
        
        if [[ "$OVERWRITE" =~ ^[Yy]$ ]]; then
            age-keygen -o "$AGE_KEY_PATH"
        fi
    else
        age-keygen -o "$AGE_KEY_PATH"
    fi
    
    AGE_PUBLIC_KEY=$(grep "# public key:" "$AGE_KEY_PATH" | cut -d: -f2 | xargs)
    cat >> "$OUTPUT_FILE" << EOF
## age Key

\`\`\`
$AGE_PUBLIC_KEY
\`\`\`

---

EOF
    echo -e "${GREEN}✓ age key generated${NC}"
    ((KEYS_GENERATED+=1))
fi

# 4. Generate Cosign Key
if [[ "$KEY_SELECTION" =~ "4" ]] && command -v cosign &> /dev/null; then
    echo -e "\n${BLUE}[Cosign] Generating Cosign key...${NC}"
    
    COSIGN_KEY_PATH="$KEY_DIR/cosign"
    COSIGN_OK=false
    
    if [ -f "${COSIGN_KEY_PATH}.pub" ]; then
        echo -e "${YELLOW}Cosign key already exists${NC}"
        echo -e "${YELLOW}Overwrite? (y/n)${NC}"
        read -p "> " OVERWRITE
        
        if [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
            COSIGN_OK=true
        else
            while true; do
                set +e
                cosign generate-key-pair --output-key-prefix "$COSIGN_KEY_PATH"
                COSIGN_STATUS=$?
                set -e

                if [ $COSIGN_STATUS -eq 0 ]; then
                    COSIGN_OK=true
                    break
                fi

                echo -e "${RED}Cosign key generation failed.${NC}"
                echo -e "${YELLOW}Try again? (y/n)${NC}"
                read -p "> " TRY_AGAIN

                if [[ ! "$TRY_AGAIN" =~ ^[Yy]$ ]]; then
                    break
                fi
            done
        fi
    else
        while true; do
            set +e
            cosign generate-key-pair --output-key-prefix "$COSIGN_KEY_PATH"
            COSIGN_STATUS=$?
            set -e

            if [ $COSIGN_STATUS -eq 0 ]; then
                COSIGN_OK=true
                break
            fi

            echo -e "${RED}Cosign key generation failed.${NC}"
            echo -e "${YELLOW}Try again? (y/n)${NC}"
            read -p "> " TRY_AGAIN

            if [[ ! "$TRY_AGAIN" =~ ^[Yy]$ ]]; then
                break
            fi
        done
    fi

    if [[ "$COSIGN_OK" == true ]] && [ -f "${COSIGN_KEY_PATH}.pub" ]; then
        COSIGN_KEY=$(cat "${COSIGN_KEY_PATH}.pub")
        cat >> "$OUTPUT_FILE" << EOF
## Cosign Key

\`\`\`
$COSIGN_KEY
\`\`\`

---

EOF
        echo -e "${GREEN}✓ Cosign key generated${NC}"
        ((KEYS_GENERATED+=1))
    else
        echo -e "${YELLOW}Skipping Cosign key.${NC}"
    fi
fi

# 5. Generate Minisign Key
if [[ "$KEY_SELECTION" =~ "5" ]] && command -v minisign &> /dev/null; then
    echo -e "\n${BLUE}[Minisign] Generating Minisign key...${NC}"
    
    MINISIGN_KEY_PATH="$KEY_DIR/minisign"
    MINISIGN_OK=false
    
    if [ -f "${MINISIGN_KEY_PATH}.pub" ]; then
        echo -e "${YELLOW}Minisign key already exists${NC}"
        echo -e "${YELLOW}Overwrite? (y/n)${NC}"
        read -p "> " OVERWRITE
        
        if [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
            MINISIGN_OK=true
        else
            while true; do
                set +e
                minisign -G -p "${MINISIGN_KEY_PATH}.pub" -s "${MINISIGN_KEY_PATH}.key"
                MINISIGN_STATUS=$?
                set -e

                if [ $MINISIGN_STATUS -eq 0 ]; then
                    MINISIGN_OK=true
                    break
                fi

                echo -e "${RED}Minisign key generation failed.${NC}"
                echo -e "${YELLOW}Try again? (y/n)${NC}"
                read -p "> " TRY_AGAIN

                if [[ ! "$TRY_AGAIN" =~ ^[Yy]$ ]]; then
                    break
                fi
            done
        fi
    else
        while true; do
            set +e
            minisign -G -p "${MINISIGN_KEY_PATH}.pub" -s "${MINISIGN_KEY_PATH}.key"
            MINISIGN_STATUS=$?
            set -e

            if [ $MINISIGN_STATUS -eq 0 ]; then
                MINISIGN_OK=true
                break
            fi

            echo -e "${RED}Minisign key generation failed.${NC}"
            echo -e "${YELLOW}Try again? (y/n)${NC}"
            read -p "> " TRY_AGAIN

            if [[ ! "$TRY_AGAIN" =~ ^[Yy]$ ]]; then
                break
            fi
        done
    fi

    if [[ "$MINISIGN_OK" == true ]] && [ -f "${MINISIGN_KEY_PATH}.pub" ]; then
        MINISIGN_KEY=$(cat "${MINISIGN_KEY_PATH}.pub")
        cat >> "$OUTPUT_FILE" << EOF
## Minisign Key

\`\`\`
$MINISIGN_KEY
\`\`\`

---

EOF
        echo -e "${GREEN}✓ Minisign key generated${NC}"
        ((KEYS_GENERATED+=1))
    else
        echo -e "${YELLOW}Skipping Minisign key.${NC}"
    fi
fi

# Add important notes
cat >> "$OUTPUT_FILE" << EOF
## Important Security Notes

- **🔴 NEVER share your private keys!**
- Private keys are stored in: \`$KEY_DIR\`
- Back up your private keys securely (encrypted backup recommended)
- Only upload the **public keys** above to omg.lol
- These keys can be used for encryption, signing, and authentication

### Key Locations

EOF

[[ "$KEY_SELECTION" =~ "1" ]] && echo "- **PGP**: Managed by GPG (use \`gpg --list-secret-keys\`)" >> "$OUTPUT_FILE"
[[ "$KEY_SELECTION" =~ "2" ]] && echo "- **SSH Private**: \`$KEY_DIR/id_ed25519\`" >> "$OUTPUT_FILE"
[[ "$KEY_SELECTION" =~ "3" ]] && echo "- **age Private**: \`$KEY_DIR/age-key.txt\`" >> "$OUTPUT_FILE"
[[ "$KEY_SELECTION" =~ "4" ]] && echo "- **Cosign Private**: \`$KEY_DIR/cosign.key\`" >> "$OUTPUT_FILE"
[[ "$KEY_SELECTION" =~ "5" ]] && echo "- **Minisign Private**: \`$KEY_DIR/minisign.key\`" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << EOF

### What These Keys Do

- **PGP**: Email encryption, code signing, identity verification
- **SSH**: Secure server access, GitHub/GitLab authentication
- **age**: Modern file encryption (replacement for PGP encryption)
- **Cosign**: Container image signing (for Docker/OCI images)
- **Minisign**: Simple file signing and verification

### Next Steps

1. Copy your public keys from this file
2. Go to your omg.lol address page
3. Click on "Keys" in the navigation
4. Paste your public keys there
5. Keep your private keys secure!

---

Generated by: https://github.com/brennanbrown/omg.lol
EOF

# Final output
clear

cat << "EOF"
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║                  ✓ SUCCESS!                               ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝

EOF

echo -e "${GREEN}Generated $KEYS_GENERATED key(s) successfully!${NC}\n"

echo -e "${BLUE}📁 Keys stored in:${NC} ${CYAN}$KEY_DIR${NC}"
echo -e "${BLUE}📄 Public keys markdown:${NC} ${CYAN}$OUTPUT_FILE${NC}\n"

echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}\n"

# Display the markdown file
cat "$OUTPUT_FILE"

echo -e "\n${YELLOW}═══════════════════════════════════════════════════════════${NC}\n"

# Offer to open the file
echo -e "${CYAN}What would you like to do next?${NC}\n"
echo "  1) Open public keys file in default editor"
echo "  2) Copy public keys file path to clipboard"
echo "  3) View security best practices"
echo "  4) Exit"
echo ""
read -p "> " NEXT_ACTION

case $NEXT_ACTION in
    1)
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open "$OUTPUT_FILE"
        else
            xdg-open "$OUTPUT_FILE" 2>/dev/null || echo -e "${YELLOW}Please open: $OUTPUT_FILE${NC}"
        fi
        ;;
    2)
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "$OUTPUT_FILE" | pbcopy
            echo -e "${GREEN}✓ Path copied to clipboard!${NC}"
        else
            echo -e "${YELLOW}File path: $OUTPUT_FILE${NC}"
        fi
        ;;
    3)
        cat << EOF

${CYAN}Security Best Practices:${NC}

${YELLOW}1. Back Up Your Private Keys${NC}
   - Use an encrypted backup solution (like Cryptomator or Veracrypt)
   - Store backups in multiple secure locations
   - Never store them in plain text in cloud storage

${YELLOW}2. Protect Your Private Keys${NC}
   - Set proper file permissions: chmod 600 on private key files
   - Consider using a password manager for key passphrases
   - Never share private keys via email or messaging

${YELLOW}3. Key Rotation${NC}
   - Rotate your keys periodically (every 1-2 years)
   - Have a plan for key compromise
   - Keep old public keys available during transition

${YELLOW}4. Use Hardware Security Keys${NC}
   - Consider YubiKey or similar for additional security
   - Use hardware keys for your most sensitive operations

${YELLOW}5. Monitor Key Usage${NC}
   - Regularly audit where your keys are deployed
   - Remove keys from unused services
   - Check for unauthorized access attempts

EOF
        ;;
    *)
        echo -e "${GREEN}All done! Have a great day! 🎉${NC}"
        ;;
esac

echo -e "\n${MAGENTA}════════════════════════════════════════════════════════════${NC}"
echo -e "${MAGENTA}  Don't forget to upload your PUBLIC keys to omg.lol!${NC}"
echo -e "${MAGENTA}════════════════════════════════════════════════════════════${NC}\n"