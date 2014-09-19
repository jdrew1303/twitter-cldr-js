# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Js
    module Renderers
      module Shared
        class CodePointRenderer < TwitterCldr::Js::Renderers::Base
          self.template_file = File.expand_path(File.join(File.dirname(__FILE__), "../..", "mustache/shared/code_point.coffee"))

          def blocks
            block_data = TwitterCldr.get_resource(:unicode_data, :blocks)
            block_data.inject({}) do |ret, (k, range)|
              ret[k] = [range.first, range.last] #{ :first => v.first, :last => v.last }
              ret
            end.to_json
          end

          def composition_exclusions
            composition_exclusions_data = TwitterCldr.get_resource(:unicode_data, :composition_exclusions)
            composition_exclusions_data.inject([]) do |ret, range|
              ret << [range.first, range.last] #{ :first => range.first, :last => range.last }
              ret
            end.to_json
          end

          def hangul_blocks
            hangul_types_data = TwitterCldr.get_resource(:unicode_data, :hangul_blocks)
            hangul_types_data.inject({}) do |ret, (k, v)|
              ret[k] = []
              v.each { |range|
                ret[k] << [range.first, range.last] # { :first => range.first, :last => range.last }
              }
              ret
            end.to_json
          end

          def canonical_compositions
            canonical_compositions_data = TwitterCldr.get_resource(:unicode_data, :canonical_compositions)
            canonical_compositions_data.inject({}) do |ret, (k, v)|
              ret [k.join("|")] = v
              ret
            end.to_json
          end

          def index_keys
            keys_data = TwitterCldr.get_resource(:unicode_data, :indices, :keys)
            keys_data.inject({}) do |ret, (k, v)|
              ret[k] = v
              ret
            end.to_json
          end

          def index_data
            index_data = {}
            [:category, :bidi_class, :bidi_mirrored].each do |key|
              data = TwitterCldr.get_resource(:unicode_data, :indices, key)
              index_data[key] = data.inject({}) do |ret, (k, v)|
                ret[k] = []
                v.each { |range|
                  ret[k] << [range.first, range.last] # { :first => range.first, :last => range.last }
                }
                ret
              end
            end
            index_data.to_json
          end

          def property_data
            property_data = {}
            [:line_break, :sentence_break, :word_break].each do |key|
              data = TwitterCldr.get_resource(:unicode_data, :properties, key)
              property_data[key] = data.inject({}) do |ret, (k, v)|
                ret[k] = []
                v.each { |range|
                  ret[k] << [range.first, range.last] # { :first => range.first, :last => range.last }
                }
                ret
              end
            end
            property_data.to_json
          end

          def block_data
            block_data = {}
            blocks = TwitterCldr.get_resource(:unicode_data, :blocks)
            blocks.each do |key, _|
              data = TwitterCldr.get_resource(:unicode_data, :blocks, key)
              block_data[key] = data.inject({}) do |ret, (k, v)|
                ret[k] = v
                ret
              end
            end
            block_data.to_json
          end

        end
      end
    end
  end
end