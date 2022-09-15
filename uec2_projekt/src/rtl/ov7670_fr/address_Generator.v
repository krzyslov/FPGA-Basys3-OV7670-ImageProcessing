//////////////////////////////////////////////////////////////////////////////////
// Company: Akademia G�rniczo-Hutnicza w Krakowie
// Engineer: Maciej Warcholak, Benedykt Bekasiak
// �r�d�o modu�u: https://www.fpga4student.com/2018/08/basys-3-fpga-ov7670-camera.html
// T�umaczone z j�zyka vhdl, przerabiane do poprawnego dzia�ania i modyfikowane
// dla uzyskania funkcjonalno�ci wymaganych przez projekt
// Create Date: 15.09.2022 10:18:28
// Project Name: Ardudido
// Tool Versions: Vivado 2017.3
//////////////////////////////////////////////////////////////////////////////////

module Address_Generator (

   input wire CLK25, 
   input wire enable,
   input wire reset,
   input wire vsync, 
   output reg [18:0] address_C,
   output reg [18:0] address_N,
   output reg [18:0] address_NE,
   output reg [18:0] address_E,
   output reg [18:0] address_SE,
   output reg [18:0] address_S,
   output reg [18:0] address_SW,
   output reg [18:0] address_W,
   output reg [18:0] address_NW
);   

	reg [18:0] address_C_nxt;

	always @ * begin
        
            
            if(vsync == 1'b0)begin
                address_C_nxt = 19'd0;
            end else begin
                if((address_C < 640*480) && (enable == 1'b1) ) begin // 640*480
                    address_C_nxt = address_C +1;
                end else begin
                    address_C_nxt = address_C;
                end
            end
            
            
        end

	
	always @(posedge CLK25) begin
		
		if (reset == 1'b1) begin
			address_C <= {19{1'b0}};
			address_N <= {19{1'b0}};
			address_NE <= {19{1'b0}};
			address_E <= {19{1'b0}};
			address_SE <= {19{1'b0}};
			address_S <= {19{1'b0}};
			address_SW <= {19{1'b0}};
			address_W <= {19{1'b0}};
			address_NW <= {19{1'b0}};
		end else begin
		
			address_C <= address_C_nxt;
			address_N <= address_C_nxt - 640;
			address_NE <= address_C_nxt - 640 + 1;
			address_E <= address_C_nxt + 1;
			address_SE <= address_C_nxt + 640 + 1;
			address_S <= address_C_nxt + 640;
			address_SW <= address_C_nxt + 640 - 1;
			address_W <= address_C_nxt - 1;
			address_NW <= address_C_nxt - 640 - 1;
		end
	end		
		
    
endmodule