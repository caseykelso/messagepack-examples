#include <string>
#include <msgpack.hpp>
#include <iostream>
#include <iomanip>
#include <numbers>
#include <limits>

void original_code()
{ 
    msgpack::sbuffer sbuf;
    msgpack::packer<msgpack::sbuffer> pk(&sbuf);
    float x = 10.1f;
    float y = 20.0f;

    pk.pack_map(2);
    pk.pack(std::string("x"));
    pk.pack(x);
    pk.pack(std::string("y"));
    pk.pack(y);

    msgpack::object_handle oh = msgpack::unpack(sbuf.data(), sbuf.size());
    msgpack::object obj = oh.get();

    std::ostringstream msg;
    msg << obj;
    std::cout << msg.str() << std::endl;
}

void force_pack_type_code()
{
    msgpack::sbuffer sbuf;
    msgpack::packer<msgpack::sbuffer> pk(&sbuf);
    float x = 10.1;
    float y = 20.0;
     
    std::cout << "input values: " << x << "," << std::fixed << std::setprecision(2) << y << std::endl;

    pk.pack_map(2);
    pk.pack(std::string("x"));
    pk.pack_float(x);
    pk.pack(std::string("y"));
    pk.pack_float(y);

    msgpack::object_handle oh = msgpack::unpack(sbuf.data(), sbuf.size());
    msgpack::object obj = oh.get();

    std::ostringstream msg;
    msg << obj;
    std::cout << "output_values: " << msg.str() << std::endl;

}

int main(int argc, char* argv[])
{
    original_code();
    force_pack_type_code();
    return EXIT_SUCCESS;
}
