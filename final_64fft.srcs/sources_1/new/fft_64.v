module fft_64(
    input clk,
    input rst_n,
    input inv,
    input valid_in,
    input sop_in,
    input [15:0] x_re,
    input [15:0] x_im,
    output reg valid_out,
    output sop_out,
    output reg [15:0] y_re,
    output reg [15:0] y_im
    );

    //输入到缓冲区
    reg signed [15:0] x_re_tmp[63:0];
    reg signed [15:0] x_im_tmp[63:0];

    integer n;
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            for(n=0;n<64;n=n+1) begin
                x_re_tmp[n] <= 0;
                x_im_tmp[n] <= 0;
            end
        end
        else begin
            for(n=0;n<63;n=n+1) begin
                x_re_tmp[n+1] <= x_re_tmp[n];
                x_im_tmp[n+1] <= x_im_tmp[n];
            end
            x_re_tmp[0] <= x_re;
            x_im_tmp[0] <= x_im;
        end
    end

    //排序
    wire signed [15:0] x_re_buf [6:0] [63:0];
    wire signed [15:0] x_im_buf [6:0] [63:0]; 

    assign x_re_buf[0][0] =  x_re_tmp[0];
    assign x_re_buf[0][1] =  x_re_tmp[32];
    assign x_re_buf[0][2] =  x_re_tmp[16];
    assign x_re_buf[0][3] =  x_re_tmp[48];
    assign x_re_buf[0][4] =  x_re_tmp[8];
    assign x_re_buf[0][5] =  x_re_tmp[40];
    assign x_re_buf[0][6] =  x_re_tmp[24];
    assign x_re_buf[0][7] =  x_re_tmp[56];
    assign x_re_buf[0][8] =  x_re_tmp[4];
    assign x_re_buf[0][9] =  x_re_tmp[36];
    assign x_re_buf[0][10] = x_re_tmp[20];
    assign x_re_buf[0][11] = x_re_tmp[52];
    assign x_re_buf[0][12] = x_re_tmp[12];
    assign x_re_buf[0][13] = x_re_tmp[44];
    assign x_re_buf[0][14] = x_re_tmp[28];
    assign x_re_buf[0][15] = x_re_tmp[60];
    assign x_re_buf[0][16] = x_re_tmp[2];
    assign x_re_buf[0][17] = x_re_tmp[34];
    assign x_re_buf[0][18] = x_re_tmp[18];
    assign x_re_buf[0][19] = x_re_tmp[50];
    assign x_re_buf[0][20] = x_re_tmp[10];
    assign x_re_buf[0][21] = x_re_tmp[42];
    assign x_re_buf[0][22] = x_re_tmp[26];
    assign x_re_buf[0][23] = x_re_tmp[58];
    assign x_re_buf[0][24] = x_re_tmp[6];
    assign x_re_buf[0][25] = x_re_tmp[38];
    assign x_re_buf[0][26] = x_re_tmp[22];
    assign x_re_buf[0][27] = x_re_tmp[54];
    assign x_re_buf[0][28] = x_re_tmp[14];
    assign x_re_buf[0][29] = x_re_tmp[46];
    assign x_re_buf[0][30] = x_re_tmp[30];
    assign x_re_buf[0][31] = x_re_tmp[62];
    assign x_re_buf[0][32] = x_re_tmp[1];
    assign x_re_buf[0][33] = x_re_tmp[33];
    assign x_re_buf[0][34] = x_re_tmp[17];
    assign x_re_buf[0][35] = x_re_tmp[49];
    assign x_re_buf[0][36] = x_re_tmp[9];
    assign x_re_buf[0][37] = x_re_tmp[41];
    assign x_re_buf[0][38] = x_re_tmp[25];
    assign x_re_buf[0][39] = x_re_tmp[57];
    assign x_re_buf[0][40] = x_re_tmp[5];
    assign x_re_buf[0][41] = x_re_tmp[37];
    assign x_re_buf[0][42] = x_re_tmp[21];
    assign x_re_buf[0][43] = x_re_tmp[53];
    assign x_re_buf[0][44] = x_re_tmp[13];
    assign x_re_buf[0][45] = x_re_tmp[45];
    assign x_re_buf[0][46] = x_re_tmp[29];
    assign x_re_buf[0][47] = x_re_tmp[61];
    assign x_re_buf[0][48] = x_re_tmp[3];
    assign x_re_buf[0][49] = x_re_tmp[35];
    assign x_re_buf[0][50] = x_re_tmp[19];
    assign x_re_buf[0][51] = x_re_tmp[51];
    assign x_re_buf[0][52] = x_re_tmp[11];
    assign x_re_buf[0][53] = x_re_tmp[43];
    assign x_re_buf[0][54] = x_re_tmp[27];
    assign x_re_buf[0][55] = x_re_tmp[59];
    assign x_re_buf[0][56] = x_re_tmp[7];
    assign x_re_buf[0][57] = x_re_tmp[39];
    assign x_re_buf[0][58] = x_re_tmp[23];
    assign x_re_buf[0][59] = x_re_tmp[55];
    assign x_re_buf[0][60] = x_re_tmp[15];
    assign x_re_buf[0][61] = x_re_tmp[47];
    assign x_re_buf[0][62] = x_re_tmp[31];
    assign x_re_buf[0][63] = x_re_tmp[63];
    
    assign x_im_buf[0][0] =  x_im_tmp[0];
    assign x_im_buf[0][1] =  x_im_tmp[32];
    assign x_im_buf[0][2] =  x_im_tmp[16];
    assign x_im_buf[0][3] =  x_im_tmp[48];
    assign x_im_buf[0][4] =  x_im_tmp[8];
    assign x_im_buf[0][5] =  x_im_tmp[40];
    assign x_im_buf[0][6] =  x_im_tmp[24];
    assign x_im_buf[0][7] =  x_im_tmp[56];
    assign x_im_buf[0][8] =  x_im_tmp[4];
    assign x_im_buf[0][9] =  x_im_tmp[36];
    assign x_im_buf[0][10] = x_im_tmp[20];
    assign x_im_buf[0][11] = x_im_tmp[52];
    assign x_im_buf[0][12] = x_im_tmp[12];
    assign x_im_buf[0][13] = x_im_tmp[44];
    assign x_im_buf[0][14] = x_im_tmp[28];
    assign x_im_buf[0][15] = x_im_tmp[60];
    assign x_im_buf[0][16] = x_im_tmp[2];
    assign x_im_buf[0][17] = x_im_tmp[34];
    assign x_im_buf[0][18] = x_im_tmp[18];
    assign x_im_buf[0][19] = x_im_tmp[50];
    assign x_im_buf[0][20] = x_im_tmp[10];
    assign x_im_buf[0][21] = x_im_tmp[42];
    assign x_im_buf[0][22] = x_im_tmp[26];
    assign x_im_buf[0][23] = x_im_tmp[58];
    assign x_im_buf[0][24] = x_im_tmp[6];
    assign x_im_buf[0][25] = x_im_tmp[38];
    assign x_im_buf[0][26] = x_im_tmp[22];
    assign x_im_buf[0][27] = x_im_tmp[54];
    assign x_im_buf[0][28] = x_im_tmp[14];
    assign x_im_buf[0][29] = x_im_tmp[46];
    assign x_im_buf[0][30] = x_im_tmp[30];
    assign x_im_buf[0][31] = x_im_tmp[62];
    assign x_im_buf[0][32] = x_im_tmp[1];
    assign x_im_buf[0][33] = x_im_tmp[33];
    assign x_im_buf[0][34] = x_im_tmp[17];
    assign x_im_buf[0][35] = x_im_tmp[49];
    assign x_im_buf[0][36] = x_im_tmp[9];
    assign x_im_buf[0][37] = x_im_tmp[41];
    assign x_im_buf[0][38] = x_im_tmp[25];
    assign x_im_buf[0][39] = x_im_tmp[57];
    assign x_im_buf[0][40] = x_im_tmp[5];
    assign x_im_buf[0][41] = x_im_tmp[37];
    assign x_im_buf[0][42] = x_im_tmp[21];
    assign x_im_buf[0][43] = x_im_tmp[53];
    assign x_im_buf[0][44] = x_im_tmp[13];
    assign x_im_buf[0][45] = x_im_tmp[45];
    assign x_im_buf[0][46] = x_im_tmp[29];
    assign x_im_buf[0][47] = x_im_tmp[61];
    assign x_im_buf[0][48] = x_im_tmp[3];
    assign x_im_buf[0][49] = x_im_tmp[35];
    assign x_im_buf[0][50] = x_im_tmp[19];
    assign x_im_buf[0][51] = x_im_tmp[51];
    assign x_im_buf[0][52] = x_im_tmp[11];
    assign x_im_buf[0][53] = x_im_tmp[43];
    assign x_im_buf[0][54] = x_im_tmp[27];
    assign x_im_buf[0][55] = x_im_tmp[59];
    assign x_im_buf[0][56] = x_im_tmp[7];
    assign x_im_buf[0][57] = x_im_tmp[39];
    assign x_im_buf[0][58] = x_im_tmp[23];
    assign x_im_buf[0][59] = x_im_tmp[55];
    assign x_im_buf[0][60] = x_im_tmp[15];
    assign x_im_buf[0][61] = x_im_tmp[47];
    assign x_im_buf[0][62] = x_im_tmp[31];
    assign x_im_buf[0][63] = x_im_tmp[63];

    //输入计数器
    wire [6:0] en_buf;

    counter #(.threshold(62)) control_u1(
        .clk(clk),
        .rst_n(rst_n),
        .valid(valid_in),
        .sop(sop_in),
        .ready(en_buf[0])
    );

    //W值
    wire signed [15:0] W_re[31:0];
    wire signed [15:0] W_im[31:0];

    assign W_re[0] = 16'h2000;
    assign W_im[0] = 16'h0000;
    assign W_re[1] = 16'h1FD8;
    assign W_im[1] = 16'hFCDD;
    assign W_re[2] = 16'h1F62;
    assign W_im[2] = 16'hF9C1;
    assign W_re[3] = 16'h1E9F;
    assign W_im[3] = 16'hF6B5;
    assign W_re[4] = 16'h1D90;
    assign W_im[4] = 16'hF3C1;
    assign W_re[5] = 16'h1C38;
    assign W_im[5] = 16'hF0EA;
    assign W_re[6] = 16'h1A9B;
    assign W_im[6] = 16'hEE38;
    assign W_re[7] = 16'h18BC;
    assign W_im[7] = 16'hEBB3;
    assign W_re[8] = 16'h16A0;
    assign W_im[8] = 16'hE95F;
    assign W_re[9] = 16'h144C;
    assign W_im[9] = 16'hE743;
    assign W_re[10] = 16'h11C7;
    assign W_im[10] = 16'hE564;
    assign W_re[11] = 16'h0F15;
    assign W_im[11] = 16'hE3C7;
    assign W_re[12] = 16'h0C3E;
    assign W_im[12] = 16'hE26F;
    assign W_re[13] = 16'h094A;
    assign W_im[13] = 16'hE160;
    assign W_re[14] = 16'h063E;
    assign W_im[14] = 16'hE09D;
    assign W_re[15] = 16'h0322;
    assign W_im[15] = 16'hE027;
    assign W_re[16] = 16'h0000;
    assign W_im[16] = 16'hE000;
    assign W_re[17] = 16'hFCDD;
    assign W_im[17] = 16'hE027;
    assign W_re[18] = 16'hF9C1;
    assign W_im[18] = 16'hE09D;
    assign W_re[19] = 16'hF6B5;
    assign W_im[19] = 16'hE160;
    assign W_re[20] = 16'hF3C1;
    assign W_im[20] = 16'hE26F;
    assign W_re[21] = 16'hF0EA;
    assign W_im[21] = 16'hE3C7;
    assign W_re[22] = 16'hEE38;
    assign W_im[22] = 16'hE564;
    assign W_re[23] = 16'hEBB3;
    assign W_im[23] = 16'hE743;
    assign W_re[24] = 16'hE95F;
    assign W_im[24] = 16'hE95F;
    assign W_re[25] = 16'hE743;
    assign W_im[25] = 16'hEBB3;
    assign W_re[26] = 16'hE564;
    assign W_im[26] = 16'hEE38;
    assign W_re[27] = 16'hE3C7;
    assign W_im[27] = 16'hF0EA;
    assign W_re[28] = 16'hE26F;
    assign W_im[28] = 16'hF3C1;
    assign W_re[29] = 16'hE160;
    assign W_im[29] = 16'hF6B5;
    assign W_re[30] = 16'hE09D;
    assign W_im[30] = 16'hF9C1;
    assign W_re[31] = 16'hE027;
    assign W_im[31] = 16'hFCDD;

    //蝶形运算单元
    genvar i,j,k;
    generate
        for(i=0;i<6;i=i+1) begin:stage
            for(j=0;j<(1<<(5-i));j=j+1) begin:group
                for(k=0;k<(1<<i);k=k+1) begin:unit
                    butterfly butterfly_u(
                        .clk(clk),
                        .rst_n(rst_n),
                        .en(en_buf[i]),
                        .x_top_re(x_re_buf[i][(j<<(i+1))+k]),
                        .x_top_im(x_im_buf[i][(j<<(i+1))+k]),
                        .x_bottom_re(x_re_buf[i][(j<<(i+1))+k+(1<<i)]),
                        .x_bottom_im(x_im_buf[i][(j<<(i+1))+k+(1<<i)]),
                        .W_re(W_re[(1<<(5-i))*k]),
                        .W_im(W_im[(1<<(5-i))*k]),
                        .vld(en_buf[i+1]),
                        .y_top_re(x_re_buf[i+1][(j<<(i+1))+k]),
                        .y_top_im(x_im_buf[i+1][(j<<(i+1))+k]),
                        .y_bottom_re(x_re_buf[i+1][(j<<(i+1))+k+(1<<i)]),
                        .y_bottom_im(x_im_buf[i+1][(j<<(i+1))+k+(1<<i)])
                    );
                end
            end
        end
    endgenerate

    //从缓冲区输出
    assign sop_out = en_buf[6];
    reg signed [15:0] y_re_tmp[63:0];
    reg signed [15:0] y_im_tmp[63:0];

    integer m;
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            for(m=0;m<64;m=m+1) begin
                y_re_tmp[m] <= 0;
                y_im_tmp[m] <= 0;
                valid_out <=0;
            end
        end
        else if(en_buf[6]) begin
            for(m=0;m<64;m=m+1) begin
                y_re_tmp[m] <= x_re_buf[6][m];
                y_im_tmp[m] <= x_im_buf[6][m];
            end
        end
        else begin
            for(m=0;m<63;m=m+1) begin
                y_re_tmp[m] <= y_re_tmp[m+1];
                y_im_tmp[m] <= y_im_tmp[m+1];
            end
        end
    end

    //逆运算
    always@(*) begin
        if(inv) begin
            y_re <= (y_im_tmp[0]>>>6);
            y_im <= (y_re_tmp[0]>>>6);
        end
        else begin
            y_re <= y_re_tmp[0];
            y_im <= y_im_tmp[0];
        end
    end

    //输出计数器
    wire over;
    counter #(.threshold(64)) counter_u2(
        .clk(clk),
        .rst_n(rst_n),
        .valid(1'b1),
        .sop(sop_out),
        .ready(over)
    );

    always@(negedge sop_out) begin
        if(!sop_out) valid_out <= 1'b1;
    end
    always@(posedge over) begin
        if(over) valid_out <= 1'b0;
    end

endmodule
