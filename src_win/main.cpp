#include <Windows.h>
#include <stdio.h>
#include <string>
#include <iostream>

// SDL Headers
#include <../lib/win/SDL2/SDL.h>
//#include <../lib/win/SDL2/SDL_image.h>

// LittlevGL
#include "../lv_conf.h"
#include "../lv_drv_conf.h"
#include <../lvgl/lvgl.h>
#include <../drivers/sdl2/driver.h>
#include "demo.h"

// Shared for both systems
#define APP_NAME "lv_platformio_win"
#define HOSTNAME = APP_NAME

#pragma region WinTools
//**********************************************************************
// Win MSVC Tools
//**********************************************************************

// Allow printf output to VS Debug without a console window
#define printf printf2
int __cdecl printf2(const char *format, ...) {
  char str[1024];

  va_list argptr;
  va_start(argptr, format);
  int ret = vsnprintf(str, sizeof(str), format, argptr);
  va_end(argptr);

  OutputDebugStringA(str);

  return ret;
}

// Convert String to LPWSTR/PCWSTR
LPWSTR ConvertString(const std::string& instr) {
  int bufferlen = ::MultiByteToWideChar(CP_ACP, 0, instr.c_str(), instr.size(), NULL, 0);
  if (bufferlen == 0) {
    return 0;
  }
  LPWSTR widestr = new WCHAR[bufferlen + 1];
  ::MultiByteToWideChar(CP_ACP, 0, instr.c_str(), instr.size(), widestr, bufferlen);
  widestr[bufferlen] = 0;

  return widestr;
}


// Get Current Folder full path
extern std::string GetFullPath(std::string AppendPath = std::string()) {
  static std::string m_path;
  
  if (m_path == "") {
    char path[_MAX_PATH];
    _fullpath( path, ".\\", _MAX_PATH );
    m_path = (std::string) path;
    printf("GetFullPath: %s\n", m_path.c_str());
  }
  return m_path + AppendPath;
}

extern char * GetFullPathC(const char * AppendPath = "") {
  static char mm_path[_MAX_PATH];
  char m_path[_MAX_PATH];
  
  if (!strlen(m_path)) {
    char path[_MAX_PATH];
    _fullpath( path, ".\\", _MAX_PATH );
    strcpy(m_path, path);
    strcpy(mm_path, m_path);
    printf("GetFullPathC: %s\n", strncat(path, AppendPath, strlen(AppendPath)));
  } else {
    strcpy(m_path, mm_path);
  }
  return strncat(m_path, AppendPath, strlen(AppendPath));
}
//**********************************************************************
#pragma endregion

#pragma region SDLWin
int ZoomScale = 1;

#define IMG_BODY "D:\\workbench\\ESP32\\lv_platformio_win\\res\\img_win\\m5stack_body.jpg"
#define IMG_LOGO "D:\\workbench\\ESP32\\lv_platformio_win\\res\\img_win\\m5stack_logo.jpg"

// SDL Consts
#define BACKGROUND_WIDTH      410
#define BACKGROUND_HEIGHT     416
#define BACKGROUND_H_OFFSET     0
#define BACKGROUND_V_OFFSET     6
#define TFT_WIDTH             320
#define TFT_HEIGHT            240

namespace FX {
  class SDL {
    private:
      SDL_Window* window = NULL;

      void create_window();
      void create_objects();
      void destroy_window();
      void destroy_objects();
      
    public:
      SDL_Texture * t_back = NULL;
      SDL_Texture * t_front = NULL;
      SDL_Renderer* renderer = NULL;
      SDL_Event event;
      SDL_Surface* background = NULL;
      SDL_Surface* esp32_window = NULL;
      SDL_Rect background_pos;
      SDL_Rect esp32_window_pos;

      int begin();
      void loop();
      void end();

      int change_zoom(int Zoom);

      // Constructor
      SDL() {};
      
      //Destructor
      ~SDL() {};
 };
}

namespace FX {
  
int SDL::begin() {
  SDL_Init(SDL_INIT_VIDEO);              // Initialize SDL2
  //IMG_Init(IMG_INIT_JPG);

  //background = IMG_Load(GetFullPathC("res\\img_win\\m5stack_body.jpg"));
  //esp32_window = IMG_Load(GetFullPathC("res\\img_win\\m5stack_logo.jpg"));

  //background = IMG_Load(IMG_BODY);
  //esp32_window = IMG_Load(IMG_LOGO);
  
  create_window();
  create_objects();
  
  return 0;
}

void SDL::end() {
  destroy_objects();
  destroy_window();

  SDL_FreeSurface(background);
  SDL_FreeSurface(esp32_window);

  //IMG_Quit();
  SDL_Quit();
}

void SDL::loop() {
}

void SDL::create_window() {
  //SDL_CreateWindowAndRenderer(BACKGROUND_WIDTH * ZoomScale, BACKGROUND_HEIGHT * ZoomScale, SDL_WINDOW_SHOWN, &window, &renderer);
  // ^ Causes Illegal Instruction when window regain focus. (?)  
  window = SDL_CreateWindow("", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, BACKGROUND_WIDTH * ZoomScale, BACKGROUND_HEIGHT * ZoomScale, SDL_WINDOW_SHOWN);
  renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_SOFTWARE);
  
  SDL_SetWindowTitle(window, APP_NAME);
}

void SDL::create_objects() {
  t_back = SDL_CreateTextureFromSurface(renderer, background);
  t_front = SDL_CreateTextureFromSurface(renderer, esp32_window);
  SDL_SetWindowIcon(window, esp32_window);

  background_pos.x = 0;
  background_pos.y = 0;
  background_pos.w = BACKGROUND_WIDTH * ZoomScale;
  background_pos.h = BACKGROUND_HEIGHT * ZoomScale;

  esp32_window_pos.x = ((BACKGROUND_WIDTH * ZoomScale) / 2 - (TFT_WIDTH * ZoomScale) / 2) - (BACKGROUND_H_OFFSET * ZoomScale);
  esp32_window_pos.y = ((BACKGROUND_HEIGHT * ZoomScale) / 2 - (TFT_HEIGHT * ZoomScale) / 2) - (BACKGROUND_V_OFFSET * ZoomScale);
  esp32_window_pos.w = TFT_WIDTH * ZoomScale;
  esp32_window_pos.h = TFT_HEIGHT * ZoomScale;  
}

void SDL::destroy_objects() {
  SDL_DestroyTexture(t_back);
  SDL_DestroyTexture(t_front);

  t_back = NULL;
  t_front = NULL;
}

void SDL::destroy_window() {
  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(window);
  
  renderer = NULL;
  window = NULL;
}

int SDL::change_zoom(int Zoom) {
  if (ZoomScale == Zoom) { return 1; }
  ZoomScale = Zoom;
  destroy_objects();
  destroy_window();
  create_window();
  create_objects();
  return 0;
}

} //namespace FX


#pragma endregion

FX::SDL fxSDL;

void win_loop();

int WINAPI wWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PWSTR szCmdLine, int CmdShow) {
  printf("Loading %s ...\n", APP_NAME);

  // LittlevGL init
  printf("LittlevGL init \n");
	lv_init();
	hw_init();
  
	demo_create();

	hw_loop();
  
  printf("Ending %s ...\n", APP_NAME);

  // SDL init without LittlevGL
  //fxSDL.begin();
  //win_loop();
  //fxSDL.end();  
}

void win_loop() {
  bool winfocus = true;
  bool quit = false;
  while (!quit) {
    SDL_WaitEvent(&fxSDL.event);

    switch (fxSDL.event.type) {
			case SDL_KEYDOWN:
        switch (fxSDL.event.key.keysym.sym) {
          case SDLK_1:
            fxSDL.change_zoom(1);
            break;
          case SDLK_2:
            fxSDL.change_zoom(2);
            break;
          case SDLK_3:
            fxSDL.change_zoom(3);
            break;
          case SDLK_ESCAPE:
            quit = true;
            break;
        }
        break;
      case SDL_WINDOWEVENT:
        switch (fxSDL.event.window.event) {
          case SDL_WINDOWEVENT_LEAVE:
          case SDL_WINDOWEVENT_FOCUS_LOST:
            winfocus = false;
            break;
          case SDL_WINDOWEVENT_ENTER:
          case SDL_WINDOWEVENT_FOCUS_GAINED:
          case SDL_WINDOWEVENT_EXPOSED:
            winfocus = true;
            break;
          case SDL_WINDOWEVENT_CLOSE:
            quit = true;
            break;
        }
        break;      
      case SDL_QUIT:
        quit = true;
        break;
    }

    if (winfocus) {
      SDL_RenderClear(fxSDL.renderer);
      SDL_RenderCopy(fxSDL.renderer, fxSDL.t_back, NULL, &fxSDL.background_pos);
      SDL_RenderCopy(fxSDL.renderer, fxSDL.t_front, NULL, &fxSDL.esp32_window_pos);
      SDL_RenderPresent(fxSDL.renderer);
    }
  }
}
