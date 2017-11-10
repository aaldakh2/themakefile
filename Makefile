# Copyright AllSeen Alliance. All rights reserved.
#
#    Permission to use, copy, modify, and/or distribute this software for any
#    purpose with or without fee is hereby granted, provided that the above
#    copyright notice and this permission notice appear in all copies.
#
#    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
#    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
#    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
#    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
#    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
#    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
#    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

# Modified by V-SQUARED, June 2016

CPPOPTS := 

ALLJOYN_DIST := $(AJ_ROOT)/build/$(OS)/$(CPU)/debug/dist/cpp

OBJ_DIR := obj/Debug

BIN_DIR := bin/Debug

ALLJOYN_CPPLIB := $(ALLJOYN_DIST)/lib
COMMON_INC := $(AJ_ROOT)/common/inc

CXXFLAGS = -Wall -pipe -std=c++11 -fno-rtti -fno-exceptions -Wno-long-long -Wno-deprecated -g -DQCC_OS_LINUX -DQCC_OS_GROUP_POSIX -DQCC_DBG -m32 -DROUTER -O0 -Wno-write-strings

LIBS = -lstdc++ -lpthread -lalljoyn -lrt -lajrouter -lm

default: DP

DP: door_provider.o
	mkdir -p $(BIN_DIR)
	$(CXX) -o $(BIN_DIR)/DP $(OBJ_DIR)/door_provider.o -L$(ALLJOYN_CPPLIB) $(LIBS)

door_provider.o: door_provider.cc $(ALLJOYN_LIB)
	mkdir -p $(OBJ_DIR)
	$(CXX) -c $(CXXFLAGS) -I$(ALLJOYN_DIST)/inc -o $(OBJ_DIR)/$@ door_provider.cc

all_clean: clean
	rmdir $(OBJ_DIR)
	rmdir $(BIN_DIR)
	rmdir bin
	rmdir obj
	rm *.plt

clean:
	rm -f $(BIN_DIR)/DP
	rm -f $(OBJ_DIR)/door_provider.o

