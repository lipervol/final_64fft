module counter#(
    parameter threshold = 64
)(
    input clk,
    input rst_n,
    input valid,
    input sop,
    output reg ready
    );

    reg [6:0] cnt;
    reg cur_state, next_state, cnt_en;

    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cur_state <= 0;
            cnt_en <= 0;
        end
        else cur_state <= next_state;
    end 

    always@(cur_state or sop or ready) begin
        case(cur_state)
            0 : if(sop) begin
                next_state = 1;
                cnt_en = 1;
            end
            else next_state = 0;
            1 : if(ready) begin
                next_state = 0;
                cnt_en = 0;
            end
            else next_state = 1;
            default : next_state = 0;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cnt <= 0;
            ready <= 0;
        end
        else if(cnt == threshold) begin 
            cnt <= 0;
            ready <= 1;
        end
        else if(valid && cnt_en) begin
            cnt <= cnt + 1;
            ready <= 0;
        end
        else begin
            cnt <= cnt;
            ready <= 0;
        end
    end

endmodule
