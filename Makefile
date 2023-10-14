OUTDIR:="build/mygraph"
INSTALL_DIR=$(shell realpath $(OUTDIR))

all: gflags glog googletest double-conversion libevent lz4 zstd openssl folly rocksdb

presetup:
	mkdir -p $(OUTDIR)

gflags: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(nproc) && \
		make install


glog: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(nproc) && \
		make install

googletest: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(nproc) && \
		make install

double-conversion: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(nproc) && \
		make install

libevent: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(nproc) && \
		make install

lz4: presetup
	cd $@ && \
	make -j $(nproc) && \
	make prefix=/ DESTDIR=$(INSTALL_DIR) install

zstd: presetup
	cd $@ && \
	make -j $(nproc) && \
	make prefix=/ DESTDIR=$(INSTALL_DIR) install

openssl: presetup
	cd $@ && \
	make -j $(nproc) && \
	make prefix=/ DESTDIR=$(INSTALL_DIR) install

folly: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(nproc) && \
		make install

rocksdb: presetup
	cd $@ && \
	mkdir -p objs && \
	cd objs && \
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
		-DCMAKE_CXX_FLAGS="-I $(INSTALL_DIR)/include" \
		.. && \
		make -j $(nproc) rocksdb && \
		make install/fast

clean:
	rm -rf $(OUTDIR)

.PHONY: presetup all clean gflags glog googletest double-conversion libevent lz4 zstd openssl folly rocksdb

#		-DINCLUDE_DIRECTORIES=$(INSTALL_DIR)/include \
#		-DLINK_DIRECTORIES=$(INSTALL_DIR)/lib \

