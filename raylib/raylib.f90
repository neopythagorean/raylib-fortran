module raylib
	use iso_c_binding
	implicit none
	
	!! Raylib Types !!

	! Color
	type, bind(C) :: Color
		character(c_char) :: r, g, b, a
	end type Color

	! Vectors
	type, bind(C) :: Vector2
		real(c_float) :: x, y
	end type Vector2

	type, bind(C) :: Vector3
		real(c_float) :: x, y, z
	end type Vector3

	type, bind(C) :: Vector4
		real(c_float) :: x, y, z, w
	end type Vector4

	! Shapes
	type, bind(C) :: Rectangle
		real(c_float) :: x, y, width, height
	end type Rectangle

	! Cameras
	! target renamed to target_point due to target being a reserved word in Fortran
	type, bind(C) :: Camera2D
		type(Vector2) :: offset, target_point
		real(c_float) :: rotation, zoom
	end type

	! Texture & Images
	! data renamed to image_data due to data being a reserved word in Fortran
	! format renamed to image_format due to format being a reserved word in Fortran
	type, bind(C) :: Image
		type(c_ptr) :: image_data
		integer(c_int) :: width, height, mipmaps, image_format
	end type Image

	type, bind(C) :: Texture2D
		integer(c_int) :: id, width, height, mipmaps, image_format
	end type Texture2D

	! Fonts
	type, bind(C) :: Font
		integer(c_int) :: baseSize, charsCount
		type(Texture2D) :: texture
		type(Rectangle) :: recs
	end type Font

	! rAudio... Idk if this will work!
	type, bind(C) :: AudioStream
		integer(c_int) :: sampleRate, sampleSize, channels
		type(c_ptr) :: buffer
	end type AudioStream
	
	type, bind(C) :: Music
		integer(c_int) :: ctxType
		type(c_ptr) :: ctxData
		integer(c_int) :: sampleCount, loopCount
		type(AudioStream) :: stream
	end type Music

	!! Raylib Enums !!
	
	! remember kids, when you cant get enums to work
	! just use ints!
	
	! Keys
	integer, parameter :: KEY_APOSTROPHE      = 39, &
				KEY_COMMA           = 44, &
				KEY_MINUS           = 45, &
				KEY_PERIOD          = 46, &
				KEY_SLASH           = 47, &
				KEY_ZERO            = 48, &
				KEY_ONE             = 49, &
				KEY_TWO             = 50, &
				KEY_THREE           = 51, &
				KEY_FOUR            = 52, &
				KEY_FIVE            = 53, &
				KEY_SIX             = 54, &
				KEY_SEVEN           = 55, &
				KEY_EIGHT           = 56, &
				KEY_NINE            = 57, &
				KEY_SEMICOLON       = 59, &
				KEY_EQUAL           = 61, &
				KEY_A               = 65, &
				KEY_B               = 66, &
				KEY_C               = 67, &
				KEY_D               = 68, &
				KEY_E               = 69, &
				KEY_F               = 70, &
				KEY_G               = 71, &
				KEY_H               = 72, &
				KEY_I               = 73, &
				KEY_J               = 74, &
				KEY_K               = 75, &
				KEY_L               = 76, &
				KEY_M               = 77, &
				KEY_N               = 78, &
				KEY_O               = 79, &
				KEY_P               = 80, &
				KEY_Q               = 81, &
				KEY_R               = 82, &
				KEY_S               = 83, &
				KEY_T               = 84, &
				KEY_U               = 85, &
				KEY_V               = 86, &
				KEY_W               = 87, &
				KEY_X               = 88, &
				KEY_Y               = 89, &
				KEY_Z               = 90, &

				! Function keys
				KEY_SPACE           = 32, &
				KEY_ESCAPE          = 256, &
				KEY_ENTER           = 257, &
				KEY_TAB             = 258, &
				KEY_BACKSPACE       = 259, &
				KEY_INSERT          = 260, &
				KEY_DELETE          = 261, &
				KEY_RIGHT           = 262, &
				KEY_LEFT            = 263, &
				KEY_DOWN            = 264, &
				KEY_UP              = 265, &
				KEY_PAGE_UP         = 266, &
				KEY_PAGE_DOWN       = 267, &
				KEY_HOME            = 268, &
				KEY_END             = 269, &
				KEY_CAPS_LOCK       = 280, &
				KEY_SCROLL_LOCK     = 281, &
				KEY_NUM_LOCK        = 282, &
				KEY_PRINT_SCREEN    = 283, &
				KEY_PAUSE           = 284, &
				KEY_F1              = 290, &
				KEY_F2              = 291, &
				KEY_F3              = 292, &
				KEY_F4              = 293, &
				KEY_F5              = 294, &
				KEY_F6              = 295, &
				KEY_F7              = 296, &
				KEY_F8              = 297, &
				KEY_F9              = 298, &
				KEY_F10             = 299, &
				KEY_F11             = 300, &
				KEY_F12             = 301, &
				KEY_LEFT_SHIFT      = 340, &
				KEY_LEFT_CONTROL    = 341, &
				KEY_LEFT_ALT        = 342, &
				KEY_LEFT_SUPER      = 343, &
				KEY_RIGHT_SHIFT     = 344, &
				KEY_RIGHT_CONTROL   = 345, &
				KEY_RIGHT_ALT       = 346, &
				KEY_RIGHT_SUPER     = 347, &
				KEY_KB_MENU         = 348, &
				KEY_LEFT_BRACKET    = 91, &
				KEY_BACKSLASH       = 92, &
				KEY_RIGHT_BRACKET   = 93, &
				KEY_GRAVE           = 96, &

				! Keypad keys
				KEY_KP_0            = 320, &
				KEY_KP_1            = 321, &
				KEY_KP_2            = 322, &
				KEY_KP_3            = 323, &
				KEY_KP_4            = 324, &
				KEY_KP_5            = 325, &
				KEY_KP_6            = 326, &
				KEY_KP_7            = 327, &
				KEY_KP_8            = 328, &
				KEY_KP_9            = 329, &
				KEY_KP_DECIMAL      = 330, &
				KEY_KP_DIVIDE       = 331, &
				KEY_KP_MULTIPLY     = 332, &
				KEY_KP_SUBTRACT     = 333, &
				KEY_KP_ADD          = 334, &
				KEY_KP_ENTER        = 335, &
				KEY_KP_EQUAL        = 336
				
	type(Color), parameter :: LIGHTGRAY = COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				GRAY 				= COLOR(CHAR(130), CHAR(130), CHAR(130), CHAR(255)), &
				DARKGRAY			= COLOR(CHAR(80), CHAR(80), CHAR(80), CHAR(255)), &
				YELLOW 				= COLOR(CHAR(253), CHAR(249), CHAR(0), CHAR(255)), &
				GOLD 				= COLOR(CHAR(255), CHAR(203), CHAR(0), CHAR(255)), &
				ORANGE 				= COLOR(CHAR(255), CHAR(161), CHAR(0), CHAR(255)), &
				PINK 				= COLOR(CHAR(255), CHAR(109), CHAR(194), CHAR(255)), &
				RED 				= COLOR(CHAR(230), CHAR(41), CHAR(55), CHAR(255)), &
				MAROON 				= COLOR(CHAR(190), CHAR(33), CHAR(55), CHAR(255)), &
				GREEN 				= COLOR(CHAR(0), CHAR(228), CHAR(48), CHAR(255)), &
				LIME 				= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				DARKGREEN 			= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				SKYBLUE 			= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				BLUE 				= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				DARKBLUE 			= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				PURPLE 				= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				VIOLET 				= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				DARKPURPLE 			= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				BEIGE 				= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				BROWN 				= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				DARKBROWN 			= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				WHITE 				= COLOR(CHAR(255), CHAR(255), CHAR(255), CHAR(255)), &
				BLACK 				= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				RAYBLANK 			= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				MAGENTA 			= COLOR(CHAR(200), CHAR(200), CHAR(200), CHAR(255)), &
				RAYWHITE 			= COLOR(CHAR(255), CHAR(255), CHAR(255), CHAR(255))
	
	interface
		subroutine InitWindow_raw(width, height, title) bind(C, NAME='InitWindow')
			use iso_c_binding
			implicit none
			integer(c_int), value :: width, height
			character :: title
		end subroutine

		subroutine SetTargetFPS(fps) bind(C, NAME='SetTargetFPS')
			use iso_c_binding
			implicit none
			integer(c_int), value :: fps
		end subroutine

		logical function WindowShouldClose() bind(C, NAME='WindowShouldClose')
			use iso_c_binding
			implicit none
		end function

		! Drawing Functions
		subroutine BeginDrawing() bind(C, NAME='BeginDrawing')
		end subroutine
		subroutine EndDrawing() bind(C, NAME='EndDrawing')
		end subroutine

		subroutine BeginMode2D(camera) bind(C, NAME='BeginMode2D')
			import :: Camera2D
			implicit none
			type(Camera2D), value :: camera
		end subroutine
		subroutine EndMode2D() bind(C, NAME='EndMode2D')
		end subroutine

		subroutine ClearBackground(set_color) bind(C, NAME='ClearBackground')
			import :: Color
			implicit none
			type(Color), value :: set_color
		end subroutine

		subroutine DrawFPS(x_pos, y_pos) bind(C, NAME='DrawFPS')
			use iso_c_binding
			implicit none
			integer(c_int), value :: x_pos, y_pos
		end subroutine

		subroutine DrawTexture(texture, x_pos, y_pos, c) bind(C, NAME='DrawTexture')
			use iso_c_binding
			import :: Texture2D, Color
			implicit none
			type(Texture2D), value :: texture
			integer(c_int), value :: x_pos, y_pos
			type(Color), value :: c
		end subroutine
		
		subroutine DrawRectangleRec(rect, c) bind(C, NAME='DrawRectangleRec')
			use iso_c_binding
			import :: Rectangle, Color
			implicit none
			type(Rectangle), value :: rect
			type(Color), value :: c
		end subroutine
		
		subroutine DrawRectangleLines(posx, posy, width, height, c) bind(C, NAME='DrawRectangleLines')
			use iso_c_binding
			import :: Color
			implicit none
			integer(c_int), value :: posx, posy, width, height
			type(Color), value :: c
		end subroutine
		
		subroutine DrawText_raw(text, posx, posy, fontsize, c) bind(C, NAME='DrawText')
			use iso_c_binding
			import :: Color
			implicit none
			character(c_char) :: text
			integer(c_int), value :: posx, posy, fontsize
			type(Color), value :: c
		end subroutine
		
		subroutine DrawPixelV(vector, c) bind(C, NAME='DrawPixelV')
			use iso_c_binding
			import :: Color, Vector2
			implicit none
			type(Vector2), value :: vector
			type(Color), value :: c
		end subroutine

		! Textures
		type(Texture2D) function LoadTexture_raw(location) bind(C, NAME='LoadTexture')
			use iso_c_binding
			import :: Texture2D
			implicit none
			character :: location
		end function
		
		subroutine UnloadTexture(texture) bind(C, NAME='UnloadTexture')
			use iso_c_binding
			import :: Texture2D
			implicit none
			type(Texture2D), value, intent(in) :: texture
		end subroutine


		! Input - Keyboard
		logical function IsKeyPressed(key) bind(C, NAME='IsKeyPressed')
			use iso_c_binding
			implicit none
			integer(c_int), value :: key
		end function
		logical function IsKeyDown(key) bind(C, NAME='IsKeyDown')
			use iso_c_binding
			implicit none
			integer(c_int), value :: key
		end function
		
		! Input - Mouse
		integer(c_int) function GetMouseX() bind(C, NAME='GetMouseX')
			use iso_c_binding
			implicit none
		end function
		integer(c_int) function GetMouseY() bind(C, NAME='GetMouseY')
			use iso_c_binding
			implicit none
		end function
		
		! rAudio
		
		subroutine InitAudioDevice() bind(C, NAME='InitAudioDevice')
		end subroutine
		
		type(Music) function LoadMusicStream(fileName) bind(C, NAME='LoadMusicStream')
			use iso_c_binding
			import :: Music
			implicit none
			character(c_char) :: fileName
		end function
		
		logical(c_bool) function IsMusicPlaying(mu) bind(C, NAME='IsMusicPlaying')
			use iso_c_binding
			import :: Music
			implicit none
			type(Music), value :: mu
		end function
		
		subroutine PlayMusicStream(mu) bind(C, NAME='PlayMusicStream')
			use iso_c_binding
			import :: Music
			implicit none
			type(Music), value :: mu
		end subroutine
		
		subroutine UpdateMusicStream(mu) bind(C, NAME='UpdateMusicStream')
			use iso_c_binding
			import :: Music
			implicit none
			type(Music), value :: mu
		end subroutine
		
		! Collisions
		
		logical(c_bool) function CheckCollisionRecs(rec1, rec2) bind(C, NAME='CheckCollisionRecs')
			use iso_c_binding
			import :: Rectangle
			implicit none
			type(Rectangle), value :: rec1, rec2
		end function
		
	end interface

contains

	! Constructors
	type(Color) function make_color(r, g, b, a) result(color_out)
		implicit none
		integer, value, intent(in) :: r, g, b, a
		color_out%r = CHAR(r)
		color_out%g = CHAR(g)
		color_out%b = CHAR(b)
		color_out%a = CHAR(a)
	end function

	type(Vector2) function make_vector2(x, y) result(vector_out)
		implicit none
		real, value, intent(in) :: x, y
		vector_out%x = x
		vector_out%y = y
	end function
	
	type(Rectangle) function make_rectangle(x, y, width, height) result(rec_out)
		implicit none
		real, value, intent(in) :: x, y, width, height
		rec_out%x = x
		rec_out%y = y
		rec_out%width = width
		rec_out%height = height
	end function
	
	! appends null to input string
	subroutine InitWindow(width, height, title)
		use iso_c_binding
		implicit none
		integer(c_int), value :: width, height
		character*(*) :: title
		call InitWindow_raw(width, height, TRIM(title)//CHAR(0))
	end subroutine

	! Texture stuff
	type(Texture2D) function LoadTexture(location) result(texture_out)
		implicit none
		character*(*) :: location
		texture_out = LoadTexture_raw(TRIM(location)//CHAR(0))
	end function

	subroutine DrawText(text, posx, posy, fontsize, c)
		use iso_c_binding
		implicit none
		character*(*) :: text
		integer(c_int), value :: posx, posy, fontsize
		type(Color), value :: c
		call DrawText_raw(TRIM(text)//CHAR(0), posx, posy, fontsize, c)
	end subroutine
end module raylib
