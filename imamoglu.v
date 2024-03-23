`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2023 16:39:10
// Design Name: 
// Module Name: imamoglu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imamoglu(

    input saat,
    input reset,
    input [31:0] buyruk,
    output reg [31:0] program_sayaci,
    output [1023:0] yazmaclar
    );
    
    reg [31:0] buyruk_r;
    reg [4:0] rs1;    
    reg [4:0] rs2;    
    reg [4:0] rd;
    reg [31:0] imm; 
    reg [2:0] funct3;
    reg s1;
    reg [1:0] s2;
    reg [31:0] bitsay_sayi;
    reg [31:0] yazmaclar_r [31:0];
    
    genvar i;
    generate 
    for (i = 0; i < 32; i = i + 1) begin
        assign yazmaclar[i*32 +: 32] = yazmaclar_r[i];
    end
    endgenerate
    
    integer k;
    always @(posedge saat) begin
        if (reset) begin
            program_sayaci <= 0;
            for (k = 0; k < 32; k = k + 1) yazmaclar_r[k] <= 0;
        end else begin
          // Fetch instruction from memory
          buyruk_r = {buyruk[7:0], buyruk[15:8], buyruk[23:16], buyruk[31:24]};
          funct3 = buyruk_r[14:12];
          case(buyruk_r[6:0])
          
            7'b1110111: begin
              // KAREAL TOPLA
              if(funct3 == 3'b000) begin
                  // Buyruklari coz
                  rs2 = buyruk_r[24:20];
                  rs1 = buyruk_r[19:15];
                  rd = buyruk_r[11:7];
                  yazmaclar_r[rd] = (yazmaclar_r[rs1]*yazmaclar_r[rs1]) + (yazmaclar_r[rs2]*yazmaclar_r[rs2]);
              end
              // CARP CIKAR
              if(funct3 == 3'b001) begin
                  // Buyruklari coz
                  rs2 = buyruk_r[24:20];
                  rs1 = buyruk_r[19:15];
                  rd = buyruk_r[11:7];  
              
                  yazmaclar_r[rd] = (yazmaclar_r[rs1]*yazmaclar_r[rs2]) - yazmaclar_r[rs1];
              end
              // SIFRELE
              if(funct3 == 3'b100) begin
                  // Buyruklari coz
                  imm = buyruk_r[31:20];
                  rs1 = buyruk_r[19:15];
                  rd = buyruk_r[11:7];  
                  imm = {20'd0, $signed(imm)};
                  
                  yazmaclar_r[rd] = yazmaclar_r[rs1] ^ imm;
              end
              // TASI
              if(funct3 == 3'b101) begin
                  // Buyruklari coz
                  imm = buyruk_r[31:20];
                  rs1 = buyruk_r[19:15];
                  rd = buyruk_r[11:7];  
                  imm = {20'd0, $signed(imm)};
              
                  yazmaclar_r[rd] = yazmaclar_r[rs1] + imm;
              end
              // BITSAY
              if (funct3 == 3'b010) begin
                  // Buyruklari coz
                  s1 = buyruk_r[31];
                  rs1 = buyruk_r[19:15];
                  rd = buyruk_r[11:7];
                  bitsay_sayi = 0;
                  for(k = 0; k < 32; k = k + 1) begin
                      if(yazmaclar_r[rs1][k] == s1)
                          bitsay_sayi = bitsay_sayi + 1;
                  end
                  yazmaclar_r[rd] = bitsay_sayi;
              end
              program_sayaci = program_sayaci + 4;
            end
            
            7'b1111111: begin
              // SEC DALLAN
              if(funct3 == 3'b111) begin
                  // Buyruklari coz
                  s2 = buyruk_r[31:30];
                  imm = {buyruk_r[7], buyruk_r[29:25], buyruk_r[11:8], 1'b0};
                  rs2 = buyruk_r[24:20];
                  rs1 = buyruk_r[19:15];
                  imm = {21'd1, $signed(imm)};
                  $display("imm: %h",imm);
                  if(s2 == 2'b00) begin // NOP    
                     program_sayaci = program_sayaci + 4; 
                  end
                  if(s2 == 2'b01) begin // BEQ rs1 rs2
                      if(yazmaclar_r[rs1] == yazmaclar_r[rs2]) 
                          program_sayaci = imm;
                      else 
                           program_sayaci = program_sayaci + 4;
                  end
                  if(s2 == 2'b10) begin // BLT rs1 rs2   
                      if(yazmaclar_r[rs1] < yazmaclar_r[rs2]) begin
                         program_sayaci = imm;
                         $display("atladý");
                      end  
                      else begin
                           program_sayaci = program_sayaci + 4;
                           $display("atlamadý");  
                      end
                  end
                  if(s2 == 2'b11) begin // BGE rs1 rs2   
                      if(yazmaclar_r[rs1] >= yazmaclar_r[rs2]) 
                         program_sayaci = imm;  
                      else 
                           program_sayaci = program_sayaci + 4;
                  end
              // IKIKAT ATLA
              end else begin
                  // Buyruklari coz
                  imm = {buyruk_r[31], buyruk_r[19:12], buyruk_r[20], buyruk_r[30:21], 1'b0};
                  rd = buyruk_r[11:7];  
                  imm = {11'd1, $signed(imm)};
                  
                  yazmaclar_r[rd] = program_sayaci + 4;
                  program_sayaci = imm*2;
                  end
            end
          endcase
        end
     end     
endmodule
