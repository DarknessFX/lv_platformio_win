#include <M5Stack.h>
#include <lvgl.h>
#include <Ticker.h>

TFT_eSPI tft = TFT_eSPI(); /* TFT instance */
static lv_disp_buf_t disp_buf;
static lv_color_t buf[LV_HOR_RES_MAX * 10];

/* Ticker.h v3.0+ - Interrupt driven periodic handler */
#define LVGL_TICK_PERIOD 20
static void lv_tick_handler(void) {
  lv_tick_inc(LVGL_TICK_PERIOD);
}
Ticker tick(lv_tick_handler, LVGL_TICK_PERIOD, 0, MICROS);

/* Display flushing */
void my_disp_flush(lv_disp_drv_t *disp, const lv_area_t *area, lv_color_t *color_p) {
  uint16_t c;

  tft.startWrite(); /* Start new TFT transaction */
  tft.setAddrWindow(area->x1, area->y1, (area->x2 - area->x1 + 1), (area->y2 - area->y1 + 1)); /* set the working window */
  for (int y = area->y1; y <= area->y2; y++) {
    for (int x = area->x1; x <= area->x2; x++) {
      c = color_p->full;
      tft.writeColor(c, 1);
      color_p++;
    }
  }
  tft.endWrite(); /* terminate TFT transaction */
  lv_disp_flush_ready(disp); /* tell lvgl that flushing is done */
}

/* Reading input device (simulated encoder here) */
bool read_encoder(lv_indev_drv_t * indev, lv_indev_data_t * data) {
  static int32_t last_diff = 0;
  int32_t diff = 0; /* Dummy - no movement */
  int btn_state = LV_INDEV_STATE_REL; /* Dummy - no press */

  data->enc_diff = diff - last_diff;;
  data->state = btn_state;

  last_diff = diff;

  return false;
}

void setup() {
  // Initialize the M5Stack object
  M5.begin(true, true, true, true);
  
  // Initialize the LittlevGL buffer, driver, tick_handler
  lv_init();
  lv_disp_buf_init(&disp_buf, buf, NULL, LV_HOR_RES_MAX * 10);
  lv_disp_drv_t disp_drv;
  lv_disp_drv_init(&disp_drv);
  disp_drv.hor_res = 320;
  disp_drv.ver_res = 240;
  disp_drv.flush_cb = my_disp_flush;
  disp_drv.buffer = &disp_buf;
  lv_disp_drv_register(&disp_drv);
  tick.start();

  /* Create simple label */
  lv_obj_t *label = lv_label_create(lv_scr_act(), NULL);
  lv_label_set_text(label, "Hello World! (v6.0)");
  lv_obj_align(label, NULL, LV_ALIGN_CENTER, 0, 0);
}

void loop() {
  if(M5.BtnA.wasPressed()) {
    M5.Power.powerOFF();
  }

  M5.update();
  tick.update();
  lv_task_handler();
  delay(5);
}
