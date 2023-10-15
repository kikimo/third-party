OUTDIR:="build/mygraph"
INSTALL_DIR=$(shell realpath $(OUTDIR))
PROCS=$(shell nproc)

all: gflags glog googletest double-conversion fmt libevent lz4 zstd openssl folly rocksdb jemalloc zlib boost_1_83_0

presetup:
	mkdir -p $(OUTDIR)
	git submodule init

zlib: presetup
	cd $@ && \
	./configure --prefix=/ && \
	make -j $(PROCS) && \
	make prefix=/ DESTDIR=$(INSTALL_DIR) install

gflags: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_STANDARD=17 \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(PROCS) && \
		make install

glog: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_STANDARD=17 \
		-DBUILD_SHARED_LIBS=OFF \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(PROCS) && \
		make install

googletest: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_STANDARD=17 \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(PROCS) && \
		make install

libunwind: presetup
	cd $@ && \
	autoreconf -i && \
	./configure --prefix=/ && \
	make -j $(PROCS) && \
	make prefix=/ DESTDIR=$(INSTALL_DIR) install

fmt: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_STANDARD=17 \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(PROCS) fmt && \
		make install/fast

double-conversion: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_STANDARD=17 \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(PROCS) && \
		make install

libevent: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_STANDARD=17 \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(PROCS) && \
		make install

lz4: presetup
	cd $@ && \
	make -j $(PROCS) && \
	make prefix=/ DESTDIR=$(INSTALL_DIR) install

zstd: presetup
	cd $@ && \
	make -j $(PROCS) && \
	make prefix=/ DESTDIR=$(INSTALL_DIR) install

openssl: presetup
	cd $@ && \
	./config --prefix=$(INSTALL_DIR) && \
	make -j $(PROCS) && \
	make install

jemalloc: presetup
	cd $@ && \
	./autogen.sh --prefix=/ && \
	make -j $(PROCS) && \
	make prefix=/ DESTDIR=$(INSTALL_DIR) install

folly: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_STANDARD=17 \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(PROCS) && \
		make install

boost_1_83_0: presetup
	cd $@ && \
	./bootstrap.sh --with-libraries=context --prefix=$(INSTALL_DIR) && \
	./b2 install

rocksdb: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_STANDARD=17 \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(PROCS) rocksdb rocksdb-shared && \
		make install/fast

clean:
	rm -rf $(OUTDIR)

.PHONY: presetup all clean gflags glog googletest double-conversion libevent lz4 zstd openssl folly rocksdb fmt jemalloc zlib boost_1_83_0

#		-DINCLUDE_DIRECTORIES=$(INSTALL_DIR)/include \
#		-DLINK_DIRECTORIES=$(INSTALL_DIR)/lib \

