# ============================================
# REMOVE DUPLICATE CHARACTERS FROM STRING
# ============================================

def remove_duplicates_manual(text):
    """Remove duplicates using loop (basic logic)"""
    result = ""
    for char in text:
        if char not in result:
            result += char
    return result


def remove_duplicates_optimized(text):
    """Remove duplicates using dictionary (optimized)"""
    return "".join(dict.fromkeys(text))


def main():
    text = input("Enter a string: ")

    if not text:
        print("Empty input!")
        return

    print("\nUsing Manual Method:", remove_duplicates_manual(text))
    print("Using Optimized Method:", remove_duplicates_optimized(text))


# Run the program
if __name__ == "__main__":
    main()