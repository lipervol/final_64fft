module butterfly(
    input clk,
    input rst_n,
    input en,
    input signed [15:0] x_top_re,
    input signed [15:0] x_top_im,
    input signed [15:0] x_bottom_re,
    input signed [15:0] x_bottom_im,
    input signed [15:0] W_re,
    input signed [15:0] W_im,
    output reg vld,
    output signed [15:0] y_top_re,
    output signed [15:0] y_top_im,
    output signed [15:0] y_bottom_re,
    output signed [15:0] y_bottom_im
    );

    reg signed [31:0] x_top_tmp_re;
    reg signed [31:0] x_top_tmp_im;
    reg signed [31:0] x_bottom_tmp_re;
    reg signed [31:0] x_bottom_tmp_im;
    wire signed [31:0] x_top_re_ex;
    wire signed [31:0] x_top_im_ex;

    assign x_top_re_ex = {{4{x_top_re[15]}}, x_top_re[14:0], 13'b0};
    assign x_top_im_ex = {{4{x_top_im[15]}}, x_top_im[14:0], 13'b0};

    always@(posedge clk or negedge rst_n) begin
        if(!rst_n || !en) begin
            x_top_tmp_re <= 0;
            x_top_tmp_im <= 0;
            x_bottom_tmp_re <= 0;
            x_bottom_tmp_im <= 0;
            vld <= 0;
        end
        else begin
            x_top_tmp_re <= x_top_re_ex + (x_bottom_re*W_re - x_bottom_im*W_im);
            x_top_tmp_im <= x_top_im_ex + (x_bottom_re*W_im + x_bottom_im*W_re);
            x_bottom_tmp_re <= x_top_re_ex - (x_bottom_re*W_re - x_bottom_im*W_im);
            x_bottom_tmp_im <= x_top_im_ex - (x_bottom_re*W_im + x_bottom_im*W_re);
            vld <= 1;
        end
    end

    assign y_top_re = {x_top_tmp_re[31],x_top_tmp_re[13+14:13]};
    assign y_top_im = {x_top_tmp_im[31],x_top_tmp_im[13+14:13]};
    assign y_bottom_re = {x_bottom_tmp_re[31],x_bottom_tmp_re[13+14:13]};
    assign y_bottom_im = {x_bottom_tmp_im[31],x_bottom_tmp_im[13+14:13]};

endmodule
