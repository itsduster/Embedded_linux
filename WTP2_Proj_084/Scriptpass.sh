#!/bin/bash

echo "***************Scripto*****************"
echo
echo -n "Wish to Proceed Further (Y/N) :"
read proceedvar

if [ "$proceedvar" = "Y" ] || [ "$proceedvar" = "y" ]; then
  echo
  echo "**************************************************"
  echo
  echo "1. Choose 1 for Existing File."
  echo "2. Choose 2 for Creating a New File."
  echo
  echo "***************************************************"
  echo 
  echo -n "Enter Your Choice :"
  read choicevar

  # Switch case
  case $choicevar in
    1)
      echo -e "\nYou chose: 1"
      echo -n "Does Your File Exist? (Y/N) :"
      read choice
      
      # Correcting the condition for checking file existence
      if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
        #chmod +x ./file_lookup.sh
        source ./file_lookup.sh
        
        if [ "$(stat -c '%U' "$PROTECTED_FILE_PATH")" = "root" ] && [ "$(stat -c '%a' "$PROTECTED_FILE_PATH")" = "600" ]; then
        echo "The file is already protected with sudo ownership and restricted permissions."
        echo
        echo -n " Do you wish to create a new file? ( Y/N ): "
        read ifchoice
        echo
        if [ $ifchoice = "Y" ] || [ $ifchoice = "y" ]; then
        case2_function
        else
        echo
        echo " Thankyou for using Scripto "
        echo "Use 'access_file' command to view the contents of the protected file."
        fi
        else
          echo
          source ./auth_file.sh
        fi
      else
        echo
        echo "You chose not to proceed with an existing file."
      fi
      ;;
      
    2)
      echo -e "\nYou chose: 2"
      echo -n "Enter the name for the new file: "
      read new_filename
      
      # Creating the new file and assigning the path
      touch "$new_filename"
      PROTECTED_FILE_PATH="./$new_filename"
      
      echo "New file created: $PROTECTED_FILE_PATH"
      echo
      echo "Adding Authentication to $PROTECTED_FILE_PATH.... Please Wait"
      source ./auth_file.sh
      ;;
    *)
      echo -e "\nInvalid choice. Please run the script again and choose a valid option."
      ;;
  esac

  echo
  echo "Thank you for using Scripto"
  echo "****************************************************"
else
  echo
  echo "You chose not to proceed. Exiting..."
fi

# Delay before closing/clearing the screen
echo
echo "Closing in 5 seconds..."

case2_function() {
      echo -n "Enter the name for the new file: "
      read new_filename
      touch "$new_filename"
      PROTECTED_FILE_PATH="./$new_filename"
      
      echo "New file created: $PROTECTED_FILE_PATH"
      echo
      echo "Adding Authentication to $PROTECTED_FILE_PATH.... Please Wait"
      source ./auth_file.sh
      }


