// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module draw_rect_char (
  output reg vsync_out,
  output reg vblnk_out,
  output reg hsync_out,
  output reg hblnk_out,
  output reg [11:0] rgb_out,
  output reg [10:0] hcount_out,
  output reg [10:0] vcount_out,
  output wire [3:0] char_line,
  output wire [7:0] char_xy,
  
  
  input wire [7:0] char_pixels,
  input wire [10:0] hcount_in,
  input wire [10:0] vcount_in,
  input wire [11:0] rgb_in,
  input wire hsync_in,
  input wire hblnk_in,
  input wire vsync_in,
  input wire vblnk_in,
  input wire pclk,
  input wire rst
  );
   
  wire [10:0] hcount_dl;
  wire [10:0] vcount_dl;
  wire hsync_dl;
  wire hblnk_dl;
  wire vsync_dl;
  wire vblnk_dl;
   wire [7:0] char_pixels_dl;
  wire [11:0] rgb_dl;
  reg  [11:0] rgb_nxt;


    delay #(
          .WIDTH (38), 
          .CLK_DEL(2)    
    ) my_delay(
    .rst(rst),
    .clk(pclk),
    .din( {hcount_in, vcount_in, hsync_in, hblnk_in, vsync_in, vblnk_in, rgb_in}),
    .dout({hcount_dl, vcount_dl, hsync_dl, hblnk_dl, vsync_dl, vblnk_dl, rgb_dl})
    );

    reg [2:0] char_y;
    reg [4:0] char_x;
    
    
    localparam rect_x =200 , rect_width = 240;
    localparam rect_y = 400, rect_height = 32;


    assign char_xy = {char_y[2:0], char_x[4:0]};
    assign char_line = {(vcount_in - rect_y) % 16};//4'h6;

    always @(*) begin

        if ((hcount_dl >= rect_x ) & (hcount_dl < rect_x + rect_width) & (vcount_dl >= rect_y ) & ( vcount_dl < rect_y + rect_height)) begin
           

            
            if ( char_pixels[3'd7 - ((hcount_dl - rect_x)%8)] == 1'b1 ) begin
                    rgb_nxt[11:0] = 12'hFFF;
            end else begin
                    rgb_nxt = 12'h000;
            end 
        end else begin
            rgb_nxt = rgb_dl;
        end 
    end
    
    
    
    
    always @(posedge pclk) begin
        if(rst) begin
            hsync_out   <= 0;
            vsync_out   <= 0;
            vcount_out  <= 0;
            hcount_out  <= 0;
            hblnk_out   <= 0;
            vblnk_out   <= 0;
            //addr        <= 0;
            rgb_out     <= 0;
            char_y      <= 0;
            char_x      <= 0;
        end else begin
            hsync_out   <= hsync_dl;
            vsync_out   <= vsync_dl;
            vcount_out  <= vcount_dl;
            hcount_out  <= hcount_dl;
            hblnk_out   <= hblnk_dl;
            vblnk_out   <= vblnk_dl;
            rgb_out     <= rgb_nxt; //rgb_nxt;
            char_y      <= (vcount_in - rect_y)/16;
            char_x      <= (hcount_in - rect_x)/8;
            //addr        <= {hcount_in[9:3], vcount_in[3:0]};
        end
        
    end
    

endmodule
