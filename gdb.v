module GCD(
    input wire clk,
    input wire rst_n,
    input wire [7:0]A,
    input wire [7:0]B,
    input wire start,
    output reg[7:0] Y,
    output reg DONE,
    output reg ERROR
);
    wire found, err, swap;
    reg [7:0] reg_a, reg_b, data_a, data_b;
    reg [7:0] diff;
    reg error_next;
    reg [1:0] state, state_next;

    parameter [1:0] IDLE = 2'b00;
    parameter [1:0] CALC = 2'b01;
    parameter [1:0] FINISH = 2'b10;

    ////assgin swap and found///////
    
    
    // the swap module have to change
    always@*begin
        if(reg_b == 0)begin
            found = 1'b1;
        end    
        else begin
            found = 1'b0;
        end
    end
    ///////////////////////// /////

    //// assign data to reg //////
    always @* begin
        if (swap) begin
            data_a = reg_b;
            data_b = reg_a;
        end
        else begin
            data_a = reg_a;
            data_b = reg_b;
        end
    end
    //////////////////////////////
    
    always @*begin
        diff = data_a -data_b;
    end

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            Y = 0;
        end
        else if(found)begin
            Y= data_a;
        end
    end

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            reg_a = 0;
            reg_b = 0;
        end
        else if(start)begin
            reg_a = A;
            reg_b = B;
        end
        else begin
            reg_a = Y;
        end
    end

    always @(posedge clk or negedge rst_n)begin
        if(rst_n == 0)begin
            state <= IDLE;
            ERROR <= 0;
        end
        else begin
            state <= state_next;
            ERROR <= error_next;
        end 
    end

    always @*begin
        case(state)
            IDLE:begin
                DONE = 0;
                if(start) begin
                    state_next = CLAC;
                    error_next = (A==0 ||B==0)?1'b1:0;
                end
                else begin
                    state_next = IDLE;
                    error_next = 0;
                end

            end
            CALC:begin
                Done = 0;
                if(found == 0)begin
                    Y = data_a - data_b;
                end
                else begin 
                    state_next = FINISH;
                end
            end
            FINISH:begin
                //here
            end
            default:begin
                DONE = 0;
                state_next = IDLE;
                error_next = 0;
            end
        endcase
    end
endmodule




























