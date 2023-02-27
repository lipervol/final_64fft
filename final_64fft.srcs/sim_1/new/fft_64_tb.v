`timescale 1ns / 1ps

module fft_64_tb();
    reg clk;
    reg rst_n;
    reg inv;
    reg valid_in;
    reg sop_in;
    reg [15:0] x_re;
    reg [15:0] x_im;
    wire valid_out;
    wire sop_out;
    wire signed [15:0] y_re;
    wire signed [15:0] y_im;

    initial begin
        clk <= 1'b0;
        rst_n <= 1'b0;
        sop_in <= 1'b0;
        valid_in <= 1'b0;
        inv <= 0;
        x_re <= 0;
        x_im <= 0;
        #30
        rst_n <= 1'b1;
        sop_in <= 1'b1;
        valid_in <= 1'b1;
        x_re <= 64;
        x_im <= 64;
        #20
        sop_in <= 1'b0;
        x_re <= 63;
        x_im <= 63;
        #20
        x_re <= 62;
        x_im <= 62;
        #20
        x_re <= 61;
        x_im <= 61;
        #20
        x_re <= 60;
        x_im <= 60;
        #20
        x_re <= 59;
        x_im <= 59;
        #20
        x_re <= 58;
        x_im <= 58;
        #20
        x_re <= 57;
        x_im <= 57;
        #20
        x_re <= 56;
        x_im <= 56;
        #20
        x_re <= 55;
        x_im <= 55;
        #20
        x_re <= 54;
        x_im <= 54;
        #20
        x_re <= 53;
        x_im <= 53;
        #20
        x_re <= 52;
        x_im <= 52;
        #20
        x_re <= 51;
        x_im <= 51;
        #20
        x_re <= 50;
        x_im <= 50;
        #20
        x_re <= 49;
        x_im <= 49;
        #20
        x_re <= 48;
        x_im <= 48;
        #20
        x_re <= 47;
        x_im <= 47;
        #20
        x_re <= 46;
        x_im <= 46;
        #20
        x_re <= 45;
        x_im <= 45;
        #20
        x_re <= 44;
        x_im <= 44;
        #20
        x_re <= 43;
        x_im <= 43;
        #20
        x_re <= 42;
        x_im <= 42;
        #20
        x_re <= 41;
        x_im <= 41;
        #20
        x_re <= 40;
        x_im <= 40;
        #20
        x_re <= 39;
        x_im <= 39;
        #20
        x_re <= 38;
        x_im <= 38;
        #20
        x_re <= 37;
        x_im <= 37;
        #20
        x_re <= 36;
        x_im <= 36;
        #20
        x_re <= 35;
        x_im <= 35;
        #20
        x_re <= 34;
        x_im <= 34;
        #20
        x_re <= 33;
        x_im <= 33;
        #20
        x_re <= 32;
        x_im <= 32;
        #20
        x_re <= 31;
        x_im <= 31;
        #20
        x_re <= 30;
        x_im <= 30;
        #20
        x_re <= 29;
        x_im <= 29;
        #20
        x_re <= 28;
        x_im <= 28;
        #20
        x_re <= 27;
        x_im <= 27;
        #20
        x_re <= 26;
        x_im <= 26;
        #20
        x_re <= 25;
        x_im <= 25;
        #20
        x_re <= 24;
        x_im <= 24;
        #20
        x_re <= 23;
        x_im <= 23;
        #20
        x_re <= 22;
        x_im <= 22;
        #20
        x_re <= 21;
        x_im <= 21;
        #20
        x_re <= 20;
        x_im <= 20;
        #20
        x_re <= 19;
        x_im <= 19;
        #20
        x_re <= 18;
        x_im <= 18;
        #20
        x_re <= 17;
        x_im <= 17;
        #20
        x_re <= 16;
        x_im <= 16;
        #20
        x_re <= 15;
        x_im <= 15;
        #20
        x_re <= 14;
        x_im <= 14;
        #20
        x_re <= 13;
        x_im <= 13;
        #20
        x_re <= 12;
        x_im <= 12;
        #20
        x_re <= 11;
        x_im <= 11;
        #20
        x_re <= 10;
        x_im <= 10;
        #20
        x_re <= 9;
        x_im <= 9;
        #20
        x_re <= 8;
        x_im <= 8;
        #20
        x_re <= 7;
        x_im <= 7;
        #20
        x_re <= 6;
        x_im <= 6;
        #20
        x_re <= 5;
        x_im <= 5;
        #20
        x_re <= 4;
        x_im <= 4;
        #20
        x_re <= 3;
        x_im <= 3;
        #20
        x_re <= 2;
        x_im <= 2;
        #20
        x_re <= 1;
        x_im <= 1;
        #20
        valid_in <= 1'b0;
    end

    always #10 clk <= ~clk;

    integer w_file;

    initial w_file = $fopen("./fft_output.txt","w+");

    always@(posedge clk) begin
        if(valid_out == 1'b1) begin
            $fwrite(w_file,"%d,%d\n",y_re,y_im);
        end
    end
    initial begin
        #4000
        $fclose(w_file);
        $stop;
    end

    fft_64 fft_64_u1(
        .clk(clk),
        .rst_n(rst_n),
        .inv(inv),
        .valid_in(valid_in),
        .sop_in(sop_in),
        .x_re(x_re),
        .x_im(x_im),
        .valid_out(valid_out),
        .sop_out(sop_out),
        .y_re(y_re),
        .y_im(y_im)
    );

endmodule
