require './test/collections_test.rb'

class CollectionsTest

  def find_ssd_only_ids(servers)
    ids = []
    servers.each do |server|
      ssd_count = 0
      server[:storage].each do |disk|
        ssd_count += 1 if disk[:type] == :ssd
      end
      ids << server[:id] if ssd_count == server[:storage].length
    end
    ids
  end

  def find_ids_with_ram_over_100(servers)
    ids = []
    servers.each do |server|
      ids << server[:id] if server[:ram].reduce(:+) > 100
    end
    ids
  end

  def find_ssd_volume_per_server (servers)
    res = []
    servers.each do |server|
      ssd_volume = 0
      server[:storage].each do |disk|
        ssd_volume += disk[:size] if disk[:type] == :ssd
      end
      res << { server[:id] => ssd_volume }
    end
    res
  end

  def sorted_ids_by_cpu_frequency(servers)
    tmp = {}
    res = []
    servers.each do |server|
      cpu_freq = 0
      server[:cpu].each do |cpu|
        cpu_freq += cpu[:cores] * cpu[:frequency]
      end
      tmp[server[:id]] = cpu_freq 
    end
    tmp.invert.keys.sort.each { |freq| res << tmp.invert[freq] }
    res
  end

end