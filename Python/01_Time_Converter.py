# ============================================
# TIME CONVERTER (Minutes → Hours + Minutes)
# ============================================

def convert_time(minutes):
    """Convert minutes into hours and remaining minutes"""
    hours = minutes // 60
    remaining = minutes % 60
    return f"{hours} hrs {remaining} minutes"


def main():
    try:
        minutes = int(input("Enter time in minutes: "))
        
        if minutes < 0:
            print("Please enter a positive number.")
            return
        
        result = convert_time(minutes)
        print("Converted Time:", result)

    except ValueError:
        print("Invalid input! Please enter a number.")


# Run the program
if __name__ == "__main__":
    main()