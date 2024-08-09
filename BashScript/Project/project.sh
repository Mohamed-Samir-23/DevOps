#!/bin/bash

# Function to display the database menu
display_db_menu() {
    echo -e "\033[1;34mDatabase Menu:\033[0m"
    echo -e "1. \033[1;32mCreate Table\033[0m"
    echo -e "2. \033[1;32mList Tables\033[0m"
    echo -e "3. \033[1;31mDrop Table\033[0m"
    echo -e "4. \033[1;33mInsert into Table\033[0m"
    echo -e "5. \033[1;33mSelect From Table\033[0m"
    echo -e "6. \033[1;31mDelete From Table\033[0m"
    echo -e "7. \033[1;33mUpdate Table\033[0m"
    echo -e "8. \033[1;34mExit to Main Menu\033[0m"
    echo -n "Please enter your choice [1-8]: "
}

# Function to display the main menu
display_menu() {
    echo -e "\033[1;34mMain Menu:\033[0m"
    echo -e "1. \033[1;32mCreate Database\033[0m"
    echo -e "2. \033[1;32mList Databases\033[0m"
    echo -e "3. \033[1;32mConnect To Database\033[0m"
    echo -e "4. \033[1;31mDrop Database\033[0m"
    echo -e "5. \033[1;31mExit\033[0m"
    echo -n "Please enter your choice [1-5]: "
}

# Function to create a new database
create_database() {
    read -p "Enter database name: " dbname

    # Check if the database name is empty
    if [ -z "$dbname" ]; then
        echo -e "\033[1;31mError:\033[0m Database name cannot be empty!"
        return 1
    fi

    # Define a regex pattern for valid database names
    # Must start with a letter only
    regex='^[a-zA-Z][a-zA-Z0-9]*$'
    
    # Check if the database name matches the regex
    if [[ ! $dbname =~ $regex ]]; then
        echo -e "\033[1;31mError:\033[0m Invalid database name. The name must start with a letter and contain only alphanumeric characters."
        return 1
    fi

    # Check if the database directory already exists
    if [ -d "databases/$dbname" ]; then
        echo -e "\033[1;31mError:\033[0m Database '$dbname' already exists."
        return 1
    fi

    # Create the database directory
    mkdir -p "databases/$dbname"
    echo -e "\033[1;32mDatabase '$dbname' created successfully.\033[0m"
}

# Function to list the databases
list_databases() {
    echo -e "\033[1;34mDatabases:\033[0m"
    ls -d databases/*/ 2>/dev/null || echo -e "\033[1;33mNo databases found.\033[0m"
}

# Function to connect to a database
connect_database() {
    echo -n "Enter the name of the database to connect to: "
    read dbname
    if [ -d "databases/$dbname" ]; then
        echo -e "\033[1;32mConnected to database '$dbname'.\033[0m"
        while :; do
            display_db_menu
            read db_choice
            case $db_choice in
                1) create_table "$dbname" ;;
                2) list_tables "$dbname" ;;
                3) drop_table "$dbname" ;;
                4) insert_into_table "$dbname" ;;
                5) select_from_table "$dbname" ;;
                6) delete_from_table "$dbname" ;;
                7) update_table "$dbname" ;;
                8) break ;;
                *) echo -e "\033[1;31mInvalid choice, please try again.\033[0m" ;;
            esac
        done
    else
        echo -e "\033[1;31mError:\033[0m Database '$dbname' does not exist."
    fi
}

# Function to drop a database
drop_database() {
    echo -n "Enter the name of the database to drop: "
    read dbname
    if [ -d "databases/$dbname" ]; then
        rm -rf "databases/$dbname" && echo -e "\033[1;32mDatabase '$dbname' dropped successfully.\033[0m" || echo -e "\033[1;31mFailed to drop database '$dbname'.\033[0m"
    else
        echo -e "\033[1;31mError:\033[0m Database '$dbname' does not exist."
    fi
}

# Function to create a table in the connected database
create_table() {
    dbname=$1
    dbpath="databases/$dbname"

    # Check if the database directory exists
    if [ ! -d "$dbpath" ]; then
        echo -e "\033[1;31mError:\033[0m Database '$dbname' does not exist."
        return 1
    fi

    echo -n "Enter the name of the new table: "
    read tablename
    if [ -z "$tablename" ]; then
        echo -e "\033[1;31mError:\033[0m Table name cannot be empty!"
        return 1
    fi
    # Define regex to check table name validity
    regex='^[a-zA-Z][a-zA-Z0-9]*$'  
    if [[ ! $tablename =~ $regex ]]; then
        echo -e "\033[1;31mError:\033[0m Invalid table name. The name must start with a letter and contain only alphanumeric characters."
        return 1
    fi

    tablefile="$dbpath/$tablename"

    if [ -f "$tablefile" ]; then
        echo -e "\033[1;31mError:\033[0m The table '$tablename' already exists."
        return 1
    fi

    echo "Enter the columns for the table (format: column_name:data_type(int,text)). Type 'done' when finished:"
    columns=()
    while :; do
        read column
        if [ "$column" == "done" ]; then
            break
        fi
        
        # Validate column format
        if [[ ! "$column" =~ ^[a-zA-Z][a-zA-Z0-9]*:(int|text)$ ]]; then
            echo -e "\033[1;31mError:\033[0m Invalid column format. Please use the format 'column_name:data_type(int,text)'."
            continue
        fi

        columns+=("$column")
    done

    if [ ${#columns[@]} -eq 0 ]; then
        echo -e "\033[1;31mError:\033[0m No columns specified. Table creation aborted."
        return 1
    fi

    # Extract just the column names for primary key validation
    column_names=()
    for col in "${columns[@]}"; do
        column_names+=("${col%%:*}")
    done

    # Ask for the primary key
    echo "Enter the primary key column name from the above list:"
    read primary_key

    if [[ ! " ${column_names[@]} " =~ " ${primary_key} " ]]; then
        echo -e "\033[1;31mError:\033[0m Primary key column not found in the column list. Table creation aborted."
        return 1
    fi

    # Create the table file with column definitions
    echo "${columns[*]}" > "$tablefile"
    echo "Primary Key: $primary_key" >> "$tablefile"
    echo -e "\033[1;32mTable '$tablename' created in database '$dbname' with columns: ${columns[*]} and primary key: $primary_key\033[0m"
}


# Function to list all tables in the connected database
list_tables() {
    dbname=$1
    echo -e "\033[1;34mList of Tables in database '$dbname':\033[0m"
    if [ ! "$(ls -A databases/$dbname)" ]; then
        echo -e "\033[1;33mNo tables found.\033[0m"
    else
        ls "databases/$dbname"
    fi
}

# Function to drop a table in the connected database
drop_table() {
    dbname=$1
    echo -n "Enter the name of the table to drop: "
    read tablename
    if [ -f "databases/$dbname/$tablename" ]; then
        rm "databases/$dbname/$tablename" && echo -e "\033[1;32mTable '$tablename' dropped from database '$dbname'.\033[0m" || echo -e "\033[1;31mFailed to drop table '$tablename'.\033[0m"
    else
        echo -e "\033[1;31mError:\033[0m Table '$tablename' does not exist."
    fi
}

# Function to insert data into a table
insert_into_table() {
    dbname=$1
    echo -n "Enter the name of the table to insert into: "
    read tablename
    tablefile="databases/$dbname/$tablename"

    if [ ! -f "$tablefile" ]; then
        echo -e "\033[1;31mError:\033[0m Table '$tablename' does not exist in database '$dbname'."
        return 1
    fi

    columns=$(head -n 1 "$tablefile")
    IFS=' ' read -r -a column_array <<< "$columns"

    data=()
    for col in "${column_array[@]}"; do
        column_name=${col%%:*}
        data_type=${col##*:}

        echo -n "Enter data for column '$column_name' ($data_type): "
        read value

        if [[ "$data_type" == "int" && ! "$value" =~ ^-?[0-9]+$ ]]; then
            echo -e "\033[1;31mError:\033[0m Invalid integer value for column '$column_name'."
            return 1
        elif [[ "$data_type" == "text" && "$value" == "" ]]; then
            echo -e "\033[1;31mError:\033[0m Text value cannot be empty for column '$column_name'."
            return 1
        fi

        data+=("$value")
    done

    echo "${data[*]}" >> "$tablefile"
    echo -e "\033[1;32mData inserted into table '$tablename'.\033[0m"
}

# Function to select data from a table
select_from_table() {
    dbname=$1
    echo -n "Enter the name of the table to select from: "
    read tablename
    tablefile="databases/$dbname/$tablename"

    if [ ! -f "$tablefile" ]; then
        echo -e "\033[1;31mError:\033[0m Table '$tablename' does not exist in database '$dbname'."
        return 1
    fi

    echo -e "\033[1;34mData in table '$tablename':\033[0m"
    cat "$tablefile"
}

# Function to delete data from a table
delete_from_table() {
    dbname=$1
    echo -n "Enter the name of the table to delete from: "
    read tablename
    tablefile="databases/$dbname/$tablename"

    if [ ! -f "$tablefile" ]; then
        echo -e "\033[1;31mError:\033[0m Table '$tablename' does not exist in database '$dbname'."
        return 1
    fi

    echo -n "Enter the row number to delete: "
    read row_number

    if [ "$row_number" -le 0 ]; then
        echo -e "\033[1;31mError:\033[0m Invalid row number."
        return 1
    fi

    sed -i "${row_number}d" "$tablefile" && echo -e "\033[1;32mRow $row_number deleted from table '$tablename'.\033[0m" || echo -e "\033[1;31mFailed to delete row $row_number from table '$tablename'.\033[0m"
}

# Function to update data in a table
update_table() {
    dbname=$1
    echo -n "Enter the name of the table to update: "
    read tablename
    tablefile="databases/$dbname/$tablename"

    if [ ! -f "$tablefile" ]; then
        echo -e "\033[1;31mError:\033[0m Table '$tablename' does not exist in database '$dbname'."
        return 1
    fi

    echo -n "Enter the row number to update: "
    read row_number

    if [ "$row_number" -le 0 ]; then
        echo -e "\033[1;31mError:\033[0m Invalid row number."
        return 1
    fi

    echo -n "Enter new data for row $row_number (format: column1_value,column2_value,...): "
    read new_data

    if [ -z "$new_data" ]; then
        echo -e "\033[1;31mError:\033[0m No data entered. Update aborted."
        return 1
    fi

    sed -i "${row_number}s/.*/$new_data/" "$tablefile" && echo -e "\033[1;32mRow $row_number updated in table '$tablename'.\033[0m" || echo -e "\033[1;31mFailed to update row $row_number in table '$tablename'.\033[0m"
}

# Main script execution
while :; do
    display_menu
    read choice
    case $choice in
        1) create_database ;;
        2) list_databases ;;
        3) connect_database ;;
        4) drop_database ;;
        5) echo -e "\033[1;34mExiting...\033[0m" && exit 0 ;;
        *) echo -e "\033[1;31mInvalid choice, please try again.\033[0m" ;;
    esac
done
