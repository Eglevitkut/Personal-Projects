def is_valid_position(position): 
    if len(position) != 2: 
        return False
    letter, digit = position[0], position[1] 
    return letter in "abcdefgh" and digit in "12345678" 

def get_white_piece_moves(piece, position): 
    letter, digit = position
    moves = [] 
    if piece == 'pawn':
        if digit != '8': 
            moves.append((letter, str(int(digit) + 1))) 
    elif piece == 'rook': 
        for d in "12345678":
            if d != digit: 
                moves.append((letter, d)) 

        for l in "abcdefgh":
            if l != letter:
                moves.append((l, digit))
    return moves #return the list of possible moves

def can_capture_white(piece, white_position, black_position): 
    white_moves = get_white_piece_moves(piece, white_position)
    return (black_position[0], black_position[1]) in white_moves 

def main():
    print("Welcome to the Chess")

    white_piece = None
    while not white_piece: 
        user_input = input("Enter the white piece and its position (e.g., 'rook a1' or 'pawn b2'): ").strip().lower() 
        if len(user_input.split()) != 2:
            print("Invalid format. Please enter in 'piece position' format.")
            continue
        piece, position = user_input.split()
        if piece not in ['pawn', 'rook']:
            print("Invalid piece. Please choose between 'pawn' and 'rook'.")
            continue
        if not is_valid_position(position):
            print("Invalid position. Please enter a valid board position (e.g., a1, b2).")
            continue
        white_piece = (piece, position)

    black_pieces = []

    while len(black_pieces) < 16: 
        user_input = input("Enter a black piece and its position (e.g., 'knight c3') or 'done' to finish: ").strip().lower()
        if user_input == 'done':
            if len(black_pieces) == 0: 
                print("You must enter at least one black piece.")
                continue
            else:
                break
        if len(user_input.split()) != 2:
            print("Invalid format. Please enter in 'piece position' format.")
            continue
        piece, position = user_input.split()
        if not is_valid_position(position):
            print("Invalid position. Please enter a valid board position (e.g., a1, b2).")
            continue
        black_pieces.append((piece, position))
        print(f"Black piece '{piece}' at position '{position}' was added successfully.")

    capturable_black_pieces = [piece for piece in black_pieces if can_capture_white(white_piece[0], white_piece[1], piece[1])]

    if capturable_black_pieces:
        print("The white piece can take over the following black pieces:")
        for piece in capturable_black_pieces:
            print(f"{piece[0]} at {piece[1]}")
    else:
        print("The white piece cannot take any black pieces.")
        print("Game Over: No more valid moves or captures.")

if __name__ == "__main__":
    main()
