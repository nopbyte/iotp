PART ?= client

ifeq ($(PART),client)
	CFLAGS += -DCLIENT
else ifeq ($(PART),server)
	CFLAGS += -DSERVER
else ifeq ($(PART),test)
	CFLAGS += -DTEST
endif

LOADLIBES += -lcrypto

TARGET_EXEC ?= $(PART).out

BUILD_DIR ?= ./$(PART)

SRCS := $(shell find *.c)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)


$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS) $(LOADLIBES)

# assembly
$(BUILD_DIR)/%.s.o: %.s
	$(MKDIR_P) $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@



.PHONY: clean

clean:
	$(RM) -r client
	$(RM) -r server

-include $(DEPS)

MKDIR_P ?= mkdir -p
