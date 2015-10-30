module Rubydora
  ##
  # This is an attempt to implement an Array-like
  # object that calls a method after data is modified
  class ArrayWithCallback < Array
    ##
    # FIXME: It would be nice to use Rubydora::Callbacks here,
    # however, this method requires instance-level callbacks

    [:<<, :collect!, :map!, :compact!, :concat, :delete, :delete_at, :delete_if, :pop, :push, :reject!, :replace, :select!, :[]=, :slice!, :uniq! ].each do |method|
      class_eval <<-RUBY
        def #{method.to_s} *args, &blk
          old = self.dup
          res = super(*args, &blk)
          call_on_change({:+ => self - old, :- => old - self})
          res
        end
      RUBY
    end

    # duck-typing Rubydora::Callbacks @hooks and accessor
    def on_change
      @hooks ||= {}
      @hooks[:on_change] ||= []
    end

    # duck-typing Rubydora::Callbacks call_* methods
    def call_on_change(changes = {})
      self.on_change.each do |h|
        h.call(self, changes)
      end
    end
  end
end
