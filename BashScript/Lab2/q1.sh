read -p "enter character: " var
case $var in
    [a-z])
        echo "Lower Case"
        ;;
    [A-Z])
        echo "Upper Case"
        ;;
    [1-9])
        echo "Number"
        ;;
    "")
        echo "Nothing"
        ;;
    *)
        echo "invalid"
        ;;
esac
        