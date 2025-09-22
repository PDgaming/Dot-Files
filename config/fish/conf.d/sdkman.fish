# SDKMAN integration for Fish shell
# Save this to ~/.config/fish/conf.d/sdkman.fish or ~/.config/fish/functions/sdk.fish

function sdk
    # Set up environment variables
    set -x SDKMAN_DIR "$HOME/.sdkman"
    
    # Create a temporary bash script to execute SDKMAN commands
    set -l bash_script (mktemp)
    
    # Write commands to the temporary bash script
    echo '#!/usr/bin/env bash' > $bash_script
    echo "export SDKMAN_DIR=\"$SDKMAN_DIR\"" >> $bash_script
    echo '[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"' >> $bash_script
    
    # Add the sdk command with all arguments
    echo "sdk $argv" >> $bash_script
    
    # If we're calling 'sdk use' or 'sdk default', we need to extract the environment variables
    if test "$argv[1]" = "use" -o "$argv[1]" = "default" -o "$argv[1]" = "home"
        # Add commands to export environment variables to a file we can source
        set -l env_file (mktemp)
        echo "env > $env_file" >> $bash_script
        
        # Make the bash script executable and run it
        chmod +x $bash_script
        bash $bash_script
        
        # Source the environment variables back into Fish
        for line in (cat $env_file)
            set parts (string split -m 1 = $line)
            set var $parts[1]
            set val $parts[2]
            
            # Skip variables that start with BASH or underscore
            if not string match -q 'BASH*' $var; and not string match -q '_*' $var
                # Remove quotes if present
                set val (string trim -c '"' $val)
                set val (string trim -c "'" $val)
                
                # Set the environment variable in Fish
                set -gx $var $val
            end
        end
        
        # Clean up the environment file
        rm $env_file
    else
        # For other commands, just execute the bash script
        chmod +x $bash_script
        bash $bash_script
    end
    
    # Clean up the temporary bash script
    rm $bash_script
end

# Initialize SDKMAN paths on shell start
if test -d "$HOME/.sdkman"
    set -gx SDKMAN_DIR "$HOME/.sdkman"
    
    # Add SDKMAN-managed binaries to PATH
    if not contains "$SDKMAN_DIR/candidates/*/current/bin" $PATH
        for dir in $SDKMAN_DIR/candidates/*/current
            if test -d "$dir/bin"
                set -gx PATH $PATH "$dir/bin"
            end
        end
    end
end

# Completions for the sdk command (basic version)
complete -c sdk -f -a "install uninstall list use default home env current upgrade version help offline selfupdate update flush"
complete -c sdk -n "__fish_seen_subcommand_from install uninstall list use default home" -a "(sdk list | grep -v = | tr -d ' ' | sort)"
