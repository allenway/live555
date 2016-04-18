#create by liulu
SHELL = bash
TARGET = rtspServer
#依赖
OBJS += main.o
OBJS += DynamicRTSPServer.o
OBJS += RHARTSPServer.o
#用于交叉编译
CROSS_COMPILE ?= arm-linux-
export CROSS_COMPILE
LIVE555_DIR = live-555
INCLUDES += -I$(LIVE555_DIR)/UsageEnvironment/include -I$(LIVE555_DIR)/groupsock/include 
INCLUDES += -I$(LIVE555_DIR)/liveMedia/include -I$(LIVE555_DIR)/BasicUsageEnvironment/include
CPP = $(CROSS_COMPILE)g++
CPLUSPLUS_FLAGS += $(INCLUDES) -I. -O2 -DSOCKLEN_T=socklen_t -DNO_SSTREAM=1 -D_LARGEFILE_SOURCE=1 
CPLUSPLUS_FLAGS += -D_FILE_OFFSET_BITS=64 -Wall -DBSD=1 -DXLOCALE_NOT_USED 
LD = $(CROSS_COMPILE)g++
LIBS +=	 $(LIVE555_DIR)/liveMedia/libliveMedia.a
LIBS +=	 $(LIVE555_DIR)/groupsock/libgroupsock.a
LIBS +=	 $(LIVE555_DIR)/BasicUsageEnvironment/libBasicUsageEnvironment.a
LIBS +=	 $(LIVE555_DIR)/UsageEnvironment/libUsageEnvironment.a
		
#编译工程
all:$(TARGET)
$(TARGET):live555_sdk $(OBJS)
	@echo $@ ...
	$(LD) -o $@ $(OBJS) $(LIBS)
	@echo $@ complete!
distclean:live555_sdk_clean
	@echo $@ ...
	@echo $@ complete!
clean:
	@echo $@ ...
	rm $(OBJS) $(TARGET) -rf
	@echo $@ complete!
install:
	@echo $@ ...
	@echo install dir:$(ROOTFS)
	@echo $@ complete!
live555_sdk:
	@echo $@ ...
	make -C $(LIVE555_DIR)
	@echo $@ complete!
live555_sdk_clean:
	@echo $@ ...
	make -C $(LIVE555_DIR) clean
	@echo $@ complete!
	
.cpp.o:
	$(CPP) -c $(CPLUSPLUS_FLAGS) $<

