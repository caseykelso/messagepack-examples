#include <string>
#include <msgpack.hpp>
#include <iostream>

void ryan_code()
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

int main(int argc, char* argv[])
{
    ryan_code();
    return EXIT_SUCCESS;
}
