require_relative "../test/class_test.rb"
require 'pp'

class CPU

  attr_accessor :socket, :frequency, :cores, :gen

  @@generations_allowed = [ 3 ]

  def initialize(socket_number, frequency, cores, gen)
    @socket = socket_number 
    @frequency = frequency
    @cores = cores
    raise "Illegal CPU generation" unless @@generations_allowed.include?(gen)
    @gen = gen
  end

  def ==(b)
    @frequency == b.frequency && @cores == b.cores && @gen == b.gen
  end

end

class Memory

  attr_accessor :type, :size

  @@allowed_types = [ :ddr4, :ddr5 ]

  def initialize(type, size)
    raise "Illegal memory type #{type}" unless @@allowed_types.include?(type)
    @type = type
    @size = size
  end

  def ==(b)
    @type == b.type && @size == b.size
  end

end

class Server

  attr_reader :memory_size

  @@max_memory_slots = 16
  @@max_cpu_sockets = 2
  
  def initialize
    @cpu_installed = false
    @cpu_sockets_used = 0
    @mem_installed = false
    @mem_slots_used = 0
    @memory_size = 0
    @bootable = false
    @cpus = []
  end

  def add_memory(mem_module)
    raise "Can't add more memory. All #{@@max_memory_slots} used." if (@mem_slots_used + 1 ) > @@max_memory_slots
    @mem_installed = true 
    @mem_slots_used += 1
    @memory_size += mem_module.size 
  end
  
  def add_cpu(new_cpu)
    raise "Can't add CPU. All #{@@max_cpu_sockets} used." if (@cpu_sockets_used + 1) > @@max_cpu_sockets
    @cpu_installed = true
    @cpu_sockets_used += 1
    @cpus.each do |cpu|
      raise "Illegal CPU type" unless cpu == new_cpu
    end
    @cpus << new_cpu
  end

  def bootable?
    @mem_installed && @cpu_installed
  end

end
