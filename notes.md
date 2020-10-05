### TO DO
[x] Overview
    - Build a sudoku game app that allows users to listen to nature sounds while playing
    - STRETCH GOALS
        - Dark mode
        - Save last game
        - Timer
        - Best time in level
[x] User stories
    - Users are able to...
        - Create account / log in to:
            - Play sudoku games with nature sounds
                - choose difficulty level
                - choose nature sounds to listen to
        - Save game(s) 
[x] establish models and relationships
    - MODELS
        - User
            - email
                - validates :email, presence: true, uniqueness: { case_sensitive: false }
            - password
                - has_secure_password
                - validates :password, confirmation: { case_sensitive: false }
            - STRETCH
                - saved game
                - best time in level
    - RELATIONSHIPS
        - none
[ ] build out back end
    - Controller
        - User
    - Routes
        - User
            - create, edit, update, destroy
[x] add serializer
    - UserSerializer
[ ] Wireframing (mockflow.com)
    - 