require 'email_callback/presenter/attribute'

class EmailCallback
  class Presenter
    class EmailAttribute < Attribute

      def label
        form_builder.label :to, 'Email'
      end

      def field
        text_field :to, max_length: 255, size: 50
      end

      def errors
        errors = email_callback.errors[:to]
        if errors.present?
          render 'shared/form_errors', errors: errors.map(&:capitalize)
        end
      end

      def to_s
        email_callback.to
      end

    end
  end
end